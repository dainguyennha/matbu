class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def index
    if params[:product_filter]
      @filter = true
      @page = params[:page]
      category_param = params[:product_filter][:category].count == 1 ? Category.all : params[:product_filter][:category]
      brand_param = params[:product_filter][:brand].count == 1 ? Brand.all : params[:product_filter][:brand]
      @hot_products = Product.where(category: category_param,
                                    brand: brand_param)
                            .order(created_at: :desc)
                            .page(params[:page])
                            .per(24)
    else 
      @filter = false
      @hot_products = Product.order(created_at: :desc).page(params[:page]).per(24)
    end
  end

  def show
    if !@product.nil?
      
      @same_products = @product.category.products.where("id != ?", @product.id).order(created_at: :desc).limit(4)
      @isAddedCard = nil
      @comment = Comment.new
      if logged_in?
        @isAddedCard = current_user.card_products.find_by(product: @product, is_order: false, type_order: "cart")
        ct_product = current_user.card_products.where(product: @product, paid: true)
        @isBought = false
        if ct_product.count > 0
          @isBought = true
        end
        @commented = current_user.comments.find_by(product: @product)
      end
    end
  end

  def new
    @product = Product.new
    @product.sizes.new
  end

  def create
    @product = Product.new product_params
    uploaded_io_s = params[:product][:images]
    if uploaded_io_s
      @product.upload_images uploaded_io_s, current_user
    end
    
    if @product.save
      redirect_to @product
    else
      byebug
    end
  end

  def edit
    @product = Product.find_by id: params[:id]
  end

  def update
    @product = Product.find_by id: params[:id]
    @product.update_attributes product_params
    uploaded_io_s = params[:product][:images]
    if uploaded_io_s
      @product.upload_images uploaded_io_s, current_user
      @product.save
    end



    
  end

  def search
    @products = Product.search_products(params[:search][:name])
      .order(created_at: :desc)
      .page(params[:page])
      .per(24)
  end

  def filter
    @products = Product.where(category: params[:product_filter][:category],
                              brand: params[:product_filter][:brand])
      .order(created_at: :desc)
      .page(params[:filter_page])
  end

  def category
    @category = Category.find_by(id: params[:id])
    if @category
      @category_name = @category.name
      @products = @category.products
        .order(created_at: :desc)
        .page(params[:page])
        .per(24)
    else
      @category_name = "Khôg tìm thấy loại sản phẩm"
      @products = Product.where(id: 0).page(params[:page])
    end
  end

  private
  def set_product
    @product = Product.find_by id: params[:id]
    not_found if @product.nil?
  end

  def product_params
    params[:product].permit(:name, :description, :price, :category_id, :brand_id, sizes_attributes: [:name, :stock, :_destroy, :id])
  end

  def filter_params
    params[:product_filter].permit(:category, :brand)
  end
end
