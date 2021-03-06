# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'
file = File.open('./db/products.csv')
csv_data = CSV.parse file, headers: true
statuses = ["Đang xử lý", "Đang giao", "Đã giao", "Đã hủy"]
statuses.each do |status|
  Status.create name: status
end
brands = ["AMELIA", "An chi", "Bonbino", "CHERRY TREE", "CIZA", "DANY SHOP", "DIDO FASHION", "CIRINO",
"EBAO", "GAGA", "Hoàngg My", "Phan Nguyen", "THE ONE FASHION", "MIMIShop", "Viet Thy"] 
brands.each do |brand|
  Brand.create name: brand
end
csv_data.each_with_index do |line, index|
  category = Category.find_or_create_by name: line["cat_name"]
  images = line["images"][2..-3].tr("'","").split(',').map{ |s| "https://cf.shopee.vn/file/"+s.strip() }
  product = Product.create name: line["name"], price: line["price"].to_i / 100000, description: line["description"],
    images: images, category: category, brand_id: 1+rand(Brand.all.count)
  product.sizes.create name: "S", stock: 100
  product.sizes.create name: "M", stock: 300
  product.sizes.create name: "L", stock: 400
  product.sizes.create name: "XL", stock: 200
end
