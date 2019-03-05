class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.integer :album_id
      t.string :image
      t.integer :image_number
      t.boolean :deleted_at

      t.timestamps
    end
  end
end
