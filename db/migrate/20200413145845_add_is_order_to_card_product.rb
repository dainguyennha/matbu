class AddIsOrderToCardProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :card_products, :is_order, :boolean, default: false
  end
end
