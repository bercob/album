class AddEscapedDirectUploadUrlToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos,:escaped_direct_upload_url, :string
  end
end
