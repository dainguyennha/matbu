class AddOrderToCardProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :card_products, :order_id, :integer
  end
end
