class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :address
      t.string :note
      t.integer :total_price
      t.boolean :paid, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
