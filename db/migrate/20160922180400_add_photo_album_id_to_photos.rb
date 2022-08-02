class AddPhotoAlbumIdToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :photo_album_id, :integer
    add_index :photos, :photo_album_id
  end
end
