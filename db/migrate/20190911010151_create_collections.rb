class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.string :uuid, index: true, unique: true, null: false
      t.references :album, null: false, foreign_key: true
      t.references :collector, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
