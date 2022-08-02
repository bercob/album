class AddDeletedToPhotoAlbums < ActiveRecord::Migration[5.1]
  def change
    add_column :photo_albums, :deleted, :boolean, null: false, default: false
    add_index :photo_albums, :deleted
  end
end
