class AddAverageRateToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :average_rate, :float, default: 3
  end
end
