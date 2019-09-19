class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string :name, null: false
      t.string :description
      t.string :uuid, index: true, unique: true, null: false
      t.integer :number_of_stickers, null: false

      t.timestamps null: false
    end
  end
end
