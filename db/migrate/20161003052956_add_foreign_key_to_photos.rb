class AddForeignKeyToPhotos < ActiveRecord::Migration
  def change
    add_foreign_key :photos, :photo_albums
  end
end
