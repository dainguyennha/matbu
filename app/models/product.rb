class Product < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :sizes , dependent: :destroy
  belongs_to :category
  has_many :card_products, dependent: :destroy

  scope :search_products, -> (name) do
    where("name LIKE ?", "%#{name.strip}%")
  end

  def cal_average_nrate new_rate
    comment_count = self.comments.count + 10
    self.average_rate = ((self.average_rate * comment_count) + new_rate)/(comment_count + 1)
  end
  def cal_average_urate updated_rate, old_rate
    comment_count = self.comments.count + 10
    self.average_rate = ((self.average_rate * comment_count) - old_rate + updated_rate)/comment_count 
  end


  def get_stock size
    self.sizes.find_by(name: size).stock
  end
end
