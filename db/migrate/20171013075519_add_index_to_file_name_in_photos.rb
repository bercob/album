class AddIndexToFileNameInPhotos < ActiveRecord::Migration[5.1]
  def change
    add_index :photos, :image_file_name
  end
end
