class Order < ApplicationRecord
  belongs_to :user
  has_many :card_products
end
