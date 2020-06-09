class OrdersController < ApplicationController
  before_action :require_loggin_page
  before_action :is_admin, only: [:show_sys, :update_status_sys, :index_sys, :sales_statistics]
  def index
    @orders = current_user.orders.order(created_at: :desc)
    
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

  def is_admin
    if !current_user.admin
      redirect_to root_url
    end
  end

  def index_sys
    if params[:search]
      o_status = params[:search][:status] == "0" ? "desc" : "asc"
      if params[:search][:show_all] == "1"
        if params[:search][:id] != ""
          @orders = Order.search_orders(params[:search][:id]).page params[:page]
        else
          @orders = Order.all.order(status_id: o_status).page params[:page]
        end
        
      else
        if params[:search][:id] != ""
          @orders = Order.get_orders_default.search_orders(params[:search][:id]).page params[:page]
        else
          @orders = Order.get_orders_default.order(status_id: o_status).page params[:page]
        end
      end
    else
      @orders = Order.get_orders_default.page params[:page]
    end
  end

  def show_sys
    @order = Order.find_by id: params[:id]
  end

  def update_status_sys
    @order = Order.find_by id: params[:id]
    
    case params[:order] [:status].to_i
    when 4
      case @order.status_id
      when 2
        @order.status_id = params[:order][:status].to_i
        recal_stock @order
      when 1
        @order.status_id = params[:order][:status].to_i
      end


    when 3
      @order.status_id = params[:order][:status].to_i
      @order.card_products.update paid: true
    when 2
      @order.status_id = params[:order][:status].to_i
      cal_stock @order
    when 1
      @order.status_id = params[:order][:status].to_i
    end
    
    @order.save

    
  end
  def cal_stock order
    order.card_products.each do |ct_product|
      product = ct_product.product
      size = product.sizes.find_by(name: ct_product.size)
      size.stock -= ct_product.count

      product.sold += ct_product.count

      product.save

      size.save
    end
    
  end

  def recal_stock order
    order.card_products.each do |ct_product|
      product = ct_product.product
      size = product.sizes.find_by(name: ct_product.size)
      size.stock += ct_product.count

      product.sold -= ct_product.count

      product.save

      size.save
    end
    
  end

  def sales_statistics
    if params[:search]
      o_sold = params[:search][:sold] == "0" ? "desc" : "asc"
      o_status = params[:search][:status] == "0" ? "desc" : "asc" 
      if o_sold == "asc" && o_status == "desc"
        @products = Product.search_products(params[:search][:name]).order(sold: o_sold).page params[:page]
      elsif o_sold == "desc" && o_status == "asc"
        @products = Product.search_products(params[:search][:name]).order(status: o_status).page params[:page]
      elsif o_sold == "asc" && o_status == "asc"
        @products = Product.search_products(params[:search][:name]).page params[:page]
      else 
        @products = Product.search_products(params[:search][:name]).order(sold: o_sold).page params[:page]
      end
    else
      @products = Product.order(sold: :desc).page params[:page]
      

    end
    @total_sold = 0
    @total_doanh_thu = 0
    Product.where("sold > 0").each do |product|
      @total_sold += product.sold
      @total_doanh_thu += product.sold * product.price
    end
    
  end

  def statistics_by_date_or_month
    @products = []
    @total_sold = 0
    @total_doanh_thu = 0

    firstTime = Time.at(params[:date_month][:begin_second].to_i)
    lastTime = Time.at(params[:date_month][:end_second].to_i)
    card_products = CardProduct.statistics_by_dm firstTime, lastTime
    products_id = card_products.pluck(:product_id).uniq
    products_id.each do |product_id|
      product = Product.find_by(id: product_id)
      count = 0
      carts_of_a_product = product.card_products.statistics_by_dm firstTime, lastTime
      carts_of_a_product.each do |cart_of_a_product|
        count += cart_of_a_product.count
      end
      @total_sold += count
      @total_doanh_thu += count * product.price
      product.solds_in_time = count

      @products.push product
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
