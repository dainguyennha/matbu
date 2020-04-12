class CardProduct < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_one :bill, :class_name => 'Bill'
end
