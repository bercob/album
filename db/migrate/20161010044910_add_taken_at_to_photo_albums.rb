class AddTakenAtToPhotoAlbums < ActiveRecord::Migration[5.1]
  def change
    add_column :photo_albums, :taken_at, :date
  end
end
