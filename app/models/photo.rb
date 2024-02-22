# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  photo_album_id     :integer
#  direct_upload_url  :string
#  processed          :boolean          default(FALSE), not null
#

class Photo < ApplicationRecord
  BUCKET_NAME = ENV['S3_BUCKET_NAME']
  DIRECT_UPLOAD_URL_FORMAT = %r{\Ahttps:\/\/s3\.#{ENV['AWS_REGION']}.amazonaws\.com\/#{BUCKET_NAME}\/(?<path>uploads\/.+\/(?<filename>.+))\z}.freeze

  belongs_to :photo_album

  scope :processed, -> { where(processed: true) }
  scope :not_processed, -> { where(processed: false) }
  scope :ordered, -> { order(image_file_name: :asc) }

  has_attached_file :image,
                    styles: {
                        original: PHOTO_STYLE_ORIGINAL,
                        showed: PHOTO_STYLE_SHOWED,
                        thumb: PHOTO_STYLE_THUMB
                    },
                    convert_options: PHOTO_CONVERT_OPTIONS

  validates_attachment :image,
                       content_type: { content_type: PHOTO_CONTENT_TYPES }

  validates :direct_upload_url, presence: true, format: { with: DIRECT_UPLOAD_URL_FORMAT }

  before_create :set_upload_attributes
  after_create :queue_finalize_and_cleanup

  # Store an unescaped version of the escaped URL that Amazon returns from direct upload.
  def direct_upload_url=(escaped_url)
    write_attribute(:direct_upload_url, (CGI.unescape(escaped_url) rescue nil))
  end
  
  # Final upload processing step:
  #
  # 1) If the file does not require processing, manually copy direct upload to
  #   the location that Paperclip expects, saving transfer time/cost.
  #   If the file requires post-processing, set the direct_upload_url as the photo's remote source,
  #   which instantiates download, process, and re-upload of the file via Paperclip callbacks.
  # 2) Flag photo as processed
  # 3) Delete the temp upload from s3.
  #
  # @see http://docs.aws.amazon.com/AmazonS3/latest/dev/CopyingObjectUsingRuby.html
  def self.finalize_and_cleanup(id)
    photo = Photo.find(id)

    direct_upload_url_data = DIRECT_UPLOAD_URL_FORMAT.match(photo.direct_upload_url)
    photo.update image: open(URI.parse(CGI.escape(photo.direct_upload_url)).to_s), processed: true

    Aws::S3::Resource.new.bucket(BUCKET_NAME).object(direct_upload_url_data[:path]).delete
  end

  # Optional: Set attachment attributes from the direct upload instead of original upload callback params
  # @note Retry logic handles occasional S3 "eventual consistency" lag.
  def set_upload_attributes
    tries ||= 5
    direct_upload_url_data = DIRECT_UPLOAD_URL_FORMAT.match(direct_upload_url)

    direct_upload_head = Aws::S3::Resource.new.bucket(BUCKET_NAME).object(direct_upload_url_data[:path]).head

    self.image_file_name     = direct_upload_url_data[:filename]
    self.image_file_size     = direct_upload_head.content_length
    self.image_content_type  = direct_upload_head.content_type
    self.image_updated_at    = direct_upload_head.last_modified
  rescue Aws::S3::Errors::NoSuchKey => e
    tries -= 1
    if tries > 0
      sleep(3)
      retry
    else
      raise e
    end
  end

  # Queue final file processing
  def queue_finalize_and_cleanup
    Photo.delay.finalize_and_cleanup(id)
  end
end
