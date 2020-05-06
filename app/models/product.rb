class Product < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :sizes , dependent: :destroy
  belongs_to :category
  has_many :card_products, dependent: :destroy
  belongs_to :brand

  accepts_nested_attributes_for :sizes, allow_destroy: true,
    reject_if: :all_blank

  scope :search_products, -> (name) do
    where("name LIKE ?", "%#{name.strip}%")
  end

  scope :get_selling_products, -> do
    where(status: "Đang kinh doanh")
  end

  def upload_images uploaded_io_s, user
    uploaded_io_s.each  do |uploaded_io|

      sys_file_name = "#{Time.now.to_i}-#{user.id}"
      File.open(Rails.root.join('public', 'assets', 'images', 'uploads', "#{sys_file_name}#{uploaded_io.original_filename}"), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      self.images.push( "/assets/images/uploads/#{sys_file_name}#{uploaded_io.original_filename}")
    end
    
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
