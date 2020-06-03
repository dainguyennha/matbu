class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def created_at_in_zone_time
    created_at.in_time_zone(+7).strftime("%H:%M:%S ngày %d/%m/%Y")
  end
end
