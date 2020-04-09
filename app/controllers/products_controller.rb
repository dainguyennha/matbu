class ProductsController < ApplicationController
# before_action :logged_in_user
  def index

    
  end

  def show
    @product = Product.find_by id: params[:id]
    @isAddedCard = current_user.card_products.find_by(product: @product)
    @comment = Comment.new
    if logged_in?
      @commented = current_user.comments.find_by(product: @product)
    end
    
  end
  def new
    @product = Product.new
    
  end
  def create
    @product = Product.new product_params
    uploaded_io_s = params[:product][:images]
    uploaded_io_s.each  do |uploaded_io|

      sys_file_name = "#{Time.now.to_i}-#{current_user.id}"
      File.open(Rails.root.join('public', 'assets', 'images', 'uploads', "#{sys_file_name}#{uploaded_io.original_filename}"), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      @product.images.push( "/assets/images/uploads/#{sys_file_name}#{uploaded_io.original_filename}")
    end
    if @product.save
      redirect_to @product
    else
    end


    
  end
  private
  def product_params
    params[:product].permit(:name, :description, :price)
  end
# def logged_in_user
#   unless logged_in?
#     store_location
#     redirect_to new_auth_session_url
#   end
# end

# def correct_user
#   @user = User.find params[:id]
#   redirect_to root_url unless @user == current_user
# end


end
