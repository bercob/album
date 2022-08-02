class AddProcessedToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :processed, :boolean, null: false, default: false
  end
end
