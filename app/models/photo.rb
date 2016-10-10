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
#

class Photo < ActiveRecord::Base
  belongs_to :photo_album

  has_attached_file :image,
                    styles: { thumb: PHOTO_STYLE_THUMB,
                              original: PHOTO_STYLE_ORIGINAL },
                    convert_options: PHOTO_CONVERT_OPTIONS

  validates_attachment :image,
                       content_type: { content_type: PHOTO_CONTENT_TYPES }

end
