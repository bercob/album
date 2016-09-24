class AddTimestampsToPhotoAlbums < ActiveRecord::Migration
  def change
    add_column(:photo_albums, :created_at, :datetime)
    add_column(:photo_albums, :updated_at, :datetime)
  end
end
