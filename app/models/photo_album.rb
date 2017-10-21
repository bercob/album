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

  def tree_children(exclude: nil, selected: nil)
    children_tree = Array.new
    self.children.not_deleted.each do |child|
      tree_hash = child.tree_hash(exclude: exclude, selected: selected)
      children_tree.push(tree_hash) if tree_hash.present?
    end
    children_tree
  end

  def tree_hash(exclude: nil, selected: nil)
    return if self == exclude
    content = { id: id, text: title }
    content[:state] = { selected: self == selected ? true : false }
    content[:children] = tree_children(exclude: exclude, selected: selected)
    content
  end

  def self.tree(exclude: nil, selected: nil)
    tree = Array.new
    self.top_parents.not_deleted.each do |top_parent|
      tree_hash = top_parent.tree_hash(exclude: exclude, selected: selected)
      tree.push(tree_hash) if tree_hash.present?
    end
    { id: '0', text: '', state: { opened: true, selected: selected.present? ? false : true }, children: tree }
  end

  def self.clean(id)
    PhotoAlbum.find(id).destroy
  end
end
