class CreateBills < ActiveRecord::Migration[5.2]
  def change
    create_table :bills do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.string :address
      t.string :note
      t.integer :total_price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
