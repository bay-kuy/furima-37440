class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :postcode,         null: false
      t.integer :prefecture_id,   null: false
      t.string :city,             null: false
      t.string :numbers,          null: false
      t.string :building
      t.string :telephone_number, null: false
      t.references :deal_log,     null: false, foreign_key: true
      t.timestamps
    end
  end
end
