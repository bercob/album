class CreatePhotoAlbums < ActiveRecord::Migration
  def change
    create_table :photo_albums do |t|
      t.string :title
      t.integer :parent_id
    end
    add_index :photo_albums, :parent_id
  end
end
