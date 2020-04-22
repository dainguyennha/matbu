class AddSizeToCardProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :card_products, :size, :string
  end
end
