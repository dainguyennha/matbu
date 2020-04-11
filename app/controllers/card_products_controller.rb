class CardProductsController < ApplicationController
  before_action :require_loggin
  skip_before_action :require_loggin, only: [:show_all]
  before_action :require_loggin_page, only: [:show_all]
  def index
    respond_to do |format|
        @card_products = current_user.card_products
        format.js
    end
  end

  def show_all
      @card_products = current_user.card_products
  end

  def create
    respond_to do |format|
        @card_product = current_user.card_products.new card_product_params 
        if @card_product.save
          format.js
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
    if @card_product.update_attributes edit_card_product_params
    end
  end

  def require_loggin
    if !logged_in?
      respond_to do |format|
        format.js { render "loggin_form.js.erb"}
      end
    end
  end

  def require_loggin_page
    if !logged_in?
     redirect_to :auth_signins_page
    end
  end

  private 
  def card_product_params
    params[:card_product].permit(:product_id, :count);
  end

  def edit_card_product_params
    params[:resource].permit(:count)
  end
end
