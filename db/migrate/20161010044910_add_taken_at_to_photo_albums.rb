class AddTakenAtToPhotoAlbums < ActiveRecord::Migration
  def change
    add_column :photo_albums, :taken_at, :date
  end
end
