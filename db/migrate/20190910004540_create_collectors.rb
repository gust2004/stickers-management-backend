class CreateCollectors < ActiveRecord::Migration[6.0]
  def change
    create_table :collectors do |t|
      t.string :name, null: false
      t.string :email, index: true, unique: true, null: false
      t.string :uuid, index: true, unique: true, null: false

      t.timestamps null: false
    end
  end
end
