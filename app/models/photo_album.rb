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
#

class PhotoAlbum < ActiveRecord::Base
  has_many :photos, -> { order(id: :asc) }, dependent: :destroy
  has_many :children, class_name: 'PhotoAlbum', foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent, class_name: 'PhotoAlbum'

  validates :title, :taken_at, presence: true

  scope :top_parents, -> { where(parent_id: nil) }
  scope :ordered, -> { order(taken_at: :desc, updated_at: :desc) }

  def has_child?
    children.any?
  end
end
