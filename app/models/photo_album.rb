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
  has_many :photos, dependent: :destroy
  has_many :children, class_name: 'PhotoAlbum', foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent, class_name: 'PhotoAlbum'

  validates :title, presence: true

  scope :top_parents, -> { where(parent_id: nil) }

  def has_child?
    children.any?
  end
end
