class Product < ApplicationRecord
  has_many :comments

  def cal_average_nrate new_rate
    comment_count = self.comments.count + 10
    self.average_rate = ((self.average_rate * comment_count) + new_rate)/(comment_count + 1)
  end
  def cal_average_urate updated_rate, old_rate
    comment_count = self.comments.count + 10
    self.average_rate = ((self.average_rate * comment_count) - old_rate + updated_rate)/comment_count 
  end
end
