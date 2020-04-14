class OrdersController < ApplicationController
  def index
    
  end
  def new
    @order = Order.new
    if params[:format].nil?
      @cart_products = current_user.get_cart_products
      @is_buy_now = false
    else
      @cart_products = CardProduct.where id: params[:format]
      @is_buy_now = true
    end

  end

  def create
    @order = current_user.orders.new order_params
    if params[:order][:ct_product].nil?
      @cart_products = current_user.get_cart_products
    else
      @cart_products = CardProduct.where id: params[:order][:ct_product]
    end
    if @cart_products.count != 0
      if @order.save
        @cart_products.update order_id: @order.id, is_order: true
        redirect_to :orders 
      else
      end
    else
      redirect_to :ct_product
    end


  end

  def show
    @orders = Order.find_by id: params[:id]
    
  end

  private
  def order_params
    params[:order].permit(:name, :phone, :email, :address, :note)
  end
end
