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
                    styles: { thumb: ["64x64#", :jpg],
                              original: ['500x500>'] },
                    convert_options: { thumb: "-quality 75 -strip",
                                       original: "-quality 85 -strip" }

  validates_attachment :image,
                       content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] }

end
