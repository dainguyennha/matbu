class CardProduct < ApplicationRecord
  belongs_to :product
  belongs_to :user


  scope :statistics_by_dm, -> (firstTime, lastTime) do
    where("updated_at >= ? AND updated_at < ?", firstTime, lastTime).where paid: true
  end
  def isEnough?
    order = Order.find_by id: self.order_id
    if order.status.id == 3 or order.status.id == 4
      return true
    else
      stock = product.sizes.find_by(name: self.size).stock
      return false if count > stock
      return true
    end
  end
end
