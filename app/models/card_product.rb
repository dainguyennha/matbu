class CardProduct < ApplicationRecord
  belongs_to :product
  belongs_to :user


  scope :statistics_by_dm, -> (firstTime, lastTime) do
    where("updated_at >= ? AND updated_at < ?", firstTime, lastTime).where paid: true
  end
end
