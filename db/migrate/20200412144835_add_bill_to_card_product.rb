class AddBillToCardProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :card_products, :bill_id, :integer
  end
end
