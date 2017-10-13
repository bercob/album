# == Schema Information
#
# Table name: photo_albums
#
#  id         :integer          not null, primary key
#  title      :string
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  taken_at   :date
#  deleted    :boolean          default(FALSE), not null
#

class PhotoAlbum < ActiveRecord::Base
  has_many :photos, dependent: :destroy
  has_many :children, class_name: 'PhotoAlbum', foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent, class_name: 'PhotoAlbum'

  validates :title, presence: true

  scope :top_parents, -> { where(parent_id: nil) }
  scope :ordered, -> { order(taken_at: :desc, updated_at: :desc) }
  scope :not_deleted, -> { where(deleted: false) }

  def has_child?
    children.any?
  end

  def self.clean(id)
    PhotoAlbum.find(id).destroy
  end
end
