class AddIndexToFileNameInPhotos < ActiveRecord::Migration
  def change
    add_index :photos, :image_file_name
  end
end
