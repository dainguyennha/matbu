class AddPaidToCardProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :card_products, :paid, :boolean, default: false
  end
end
