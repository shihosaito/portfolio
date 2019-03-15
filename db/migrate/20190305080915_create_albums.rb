class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.integer :user_id
      t.string :album_name
      t.string :password_digest, null: false
      t.boolean :deleted_at

      t.timestamps
    end
  end
end
