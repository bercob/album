class RemoveTitleFromPhotos < ActiveRecord::Migration[5.1]
  def change
    remove_column :photos, :title
  end
end
