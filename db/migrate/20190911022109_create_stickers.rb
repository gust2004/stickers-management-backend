class CreateStickers < ActiveRecord::Migration[6.0]
  def change
    create_table :stickers do |t|
      t.string :uuid, index: true, unique: true, null: false
      t.references :collection, null: false, foreign_key: true
      t.integer :number, null: false
      t.integer :quantity, null: false, default: 0

      t.timestamps null: false
    end
  end
end
