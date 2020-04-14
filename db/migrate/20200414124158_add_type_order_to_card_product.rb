class AddTypeOrderToCardProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :card_products, :type_order, :string, default: "cart"
  end
end
