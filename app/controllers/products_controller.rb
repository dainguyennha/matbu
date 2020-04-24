class ProductsController < ApplicationController
# before_action :logged_in_user
  def index
    @hot_products = Product.order(created_at: :desc).page(params[:page]).per(24)
  end

  def show
    @product = Product.find_by id: params[:id]
    @same_products = @product.category.products.where("id != ?", @product.id).order(created_at: :desc).limit(4)

    @isAddedCard = nil
    @comment = Comment.new
    if logged_in?
      @isAddedCard = current_user.card_products.find_by(product: @product, is_order: false, type_order: "cart")
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
  def search
    @products = Product.search_products(params[:search][:name])
      .order(created_at: :desc)
      .page(params[:page])
      .per(24)
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
