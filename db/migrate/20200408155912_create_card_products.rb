class CreateCardProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :card_products do |t|
      t.references :product, foreign_key: true
      t.integer :count
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
