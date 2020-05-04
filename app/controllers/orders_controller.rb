class OrdersController < ApplicationController
  before_action :require_loggin_page
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
    @order.status = Status.first
    if params[:order][:ct_product].nil?
      @cart_products = current_user.get_cart_products
    else
      @cart_products = CardProduct.where id: params[:order][:ct_product]
    end
    if @cart_products.count != 0
      if @order.save
        @cart_products.update order_id: @order.id, is_order: true
        total_price = 0
        @cart_products.each do |ct_product|
          ct_product.name = ct_product.product.name
          ct_product.price = ct_product.product.price
          ct_product.image = ct_product.product.images[0]

          ct_product.save
          total_price += ct_product.price * ct_product.count
        end

        @order.update total_price: total_price
        redirect_to :orders 
      elsif @order.invalid?
        respond_to do |format|
          format.js
        end
      end
    else
      redirect_to :ct_product
    end
  end

  def show
    @order = Order.find_by id: params[:id]
    
  end

  def index_sys
    @orders = Order.get_orders_default
  end

  def show_sys
    @order = Order.find_by id: params[:id]
  end

  def update_status_sys
    @order = Order.find_by id: params[:id]
    @order.status_id = params[:order][:status].to_i
    case @order.status_id
    when 3
      @order.card_products.update paid: true
    when 2
      cal_stock @order
      
    end
    @order.save

    
  end
  def cal_stock order
    order.card_products.each do |ct_product|
      size = ct_product.product.sizes.find_by(name: ct_product.size)
      size.stock -= ct_product.count
      size.save
    end
    
  end

  private
  def order_params
    params[:order].permit(:name, :phone, :email, :address, :note)
  end

  def order_status_params
    params[:order].permit(:status)
  end


  def require_loggin
    if !logged_in?
      respond_to do |format|
        format.js { render "loggin_form.js.erb"}
      end
    end
  end
end
