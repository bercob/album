class AddForeignKeyToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :photos, :photo_albums
  end
end
