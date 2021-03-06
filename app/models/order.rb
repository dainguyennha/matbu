class Order < ApplicationRecord
  belongs_to :user
  has_many :card_products
  belongs_to :status

  validates :name, :presence => { message: "Tên không được để trống"}
  VALID_PHONE_REGEX = /\b(0)+[2-9]+([0-9]{8})\b/
  validates :phone, presence: { message: "Số điện thoại không được để trống"}
  validates :phone,allow_blank: true, format: { with: VALID_PHONE_REGEX, \
    message: "Số điện thoại không hợp lệ!"}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: { message: "Email không được để trống!"}
  validates :email, allow_blank: true, length: { maximum: 250 },
    format: { with: VALID_EMAIL_REGEX, message: "Email không hợp lệ!" }
  validates :address, :presence => { message: "Địa chỉ không được để trống"}

  scope :get_orders_default, -> do
    where(status_id: [1, 2])
  end

  scope :search_orders, -> (id) do
    where(id: id)
  end

  scope :statistics_by_dm, -> (firstTime, lastTime) do
    where("updated_at >= ? AND updated_at < ?", firstTime, lastTime).where status_id: 3
  end

  def created_at_in_zone_time
    created_at.in_time_zone(+7).strftime("%H:%M:%S ngày %d/%m/%Y")
  end

  def isEnough?
    if status.id == 3 or status.id == 4
      return true
    else
      cart_products = self.card_products
      cart_products.each do |card_product|
        stock = card_product.product.sizes.find_by(name: card_product.size).stock
        return false if card_product.count > stock
      end
      return true

    end
  end
end
