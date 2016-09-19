# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Photo < ActiveRecord::Base
  has_attached_file :image,
                    styles: { thumb: ["64x64#", :jpg],
                              original: ['500x500>'] },
                    convert_options: { thumb: "-quality 75 -strip",
                                       original: "-quality 85 -strip" }

  validates_attachment :image,
                       content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] }

  validates :title, presence: true
  validate :file_presence

  private

  def file_presence
    errors.add(:images, I18n.t('photos.alerts.select_photos')) unless image?
  end

end
