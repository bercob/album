class AddProcessedToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :processed, :boolean, null: false, default: false
  end
end
