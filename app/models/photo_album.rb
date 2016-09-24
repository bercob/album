# == Schema Information
#
# Table name: photo_albums
#
#  id         :integer          not null, primary key
#  title      :string
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class PhotoAlbum < ActiveRecord::Base
  has_many :photos, dependent: :delete_all
  # has_many :child_photo_albums, foreign_key: :parent_id, dependent: :delete_all

  validates :title, presence: true

  scope :children, -> (id) { where(parent_id: id) }

  def has_child?
    PhotoAlbum.children(id).any?
  end
end
