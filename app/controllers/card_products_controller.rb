class CardProductsController < ApplicationController
  before_action :require_loggin
  skip_before_action :require_loggin, only: [:show_all]
  before_action :require_loggin_page, only: [:show_all]
  def index
    respond_to do |format|
        @card_products = current_user.get_cart_products
        format.js
    end
  end

  def show_all
      @card_products = current_user.get_cart_products
  end

  def new
    @product = Product.find_by id: params[:id]
    respond_to do |format|
      format.js
    end
  end
  def create
        @card_product = current_user.card_products.new card_product_params 
        if @card_product.save
          if @card_product.type_order == "cart"
            respond_to do |format|
              format.js
            end
          elsif @card_product.type_order == "buy"
            redirect_to new_order_url(@card_product.id)
          end
        end
    
  end

  def destroy
    @card_product = CardProduct.find_by id: params[:id]
    @card_product.destroy
    respond_to do |format|
      format.js
    end
  end

  def update
    @card_product = CardProduct.find_by id: params[:id]
    if @card_product.update_attributes edit_card_product_params @card_product
      render json: {count: @card_product.count}, status: :ok
    end
  end

  def require_loggin
    if !logged_in?
      respond_to do |format|
        format.js { render "loggin_form.js.erb"}
      end
    end
  end

  

  private 
  def card_product_params
    stock = Product.find_by(id: params[:card_product][:product_id]).sizes.find_by(name: params[:card_product][:size]).stock
    if params[:card_product][:count].to_i < 1
      params[:card_product][:count] = 1
    elsif params[:card_product][:count].to_i > stock
      params[:card_product][:count] = stock
    else
      params[:card_product][:count] = params[:card_product][:count].to_i
    end
    params[:card_product].permit(:product_id, :count, :type_order, :size);
  end

  def edit_card_product_params cart_product
    stock = cart_product.product.sizes.find_by(name: cart_product.size).stock
    if params[:resource][:count].to_i < 1
      params[:resource][:count] = 1
    elsif params[:resource][:count].to_i > stock
      params[:resource][:count] = stock
    else
      params[:resource][:count] = params[:resource][:count].to_i
    end
    params[:resource].permit(:count)
  end
end
