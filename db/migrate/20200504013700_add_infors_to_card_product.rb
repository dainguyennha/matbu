class AddInforsToCardProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :card_products, :name, :string
    add_column :card_products, :price, :integer
    add_column :card_products, :image, :string
  end
end
