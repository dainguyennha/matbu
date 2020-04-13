class OrdersController < ApplicationController
  def index
    
  end
  def new
    @order = Order.new
    @cart_products = current_user.get_cart_products

  end

  def create
    @order = current_user.orders.new order_params
    @cart_products = current_user.get_cart_products
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
