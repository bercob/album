class AddColumnsToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos,:direct_upload_url, :string
  end
end
