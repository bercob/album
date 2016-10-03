class AddForeignKeyToPhotos < ActiveRecord::Migration
  def change
    add_foreign_key :photos, :photo_album_id
  end
end
