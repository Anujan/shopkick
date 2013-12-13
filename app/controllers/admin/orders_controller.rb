class Admin::OrdersController < Admin::BaseController
  before_filter :current_order, only: [:edit, :update, :destroy, :show]

  def index
    @orders = Order.order('created_at DESC')
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(params[:order])
    if @order.save
      flash[:notice] = "Order ##{@order.id} has been created!"
      redirect_to admin_orders_url
    else
      flash.now[:errors] = @order.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @order.update_attributes(params[:order])
      flash[:notice] = "Order ##{@order.id} has been updated!"
      redirect_to admin_orders_url
    else
      flash.now[:errors] = @order.errors.full_messsages
      render :edit
    end
  end

  def destroy
    if @order.destroy
      flash[:notice] = "Order ##{@order.id} has been deleted!"
      redirect_to admin_orders_url
    end
  end

  def current_order
    @order = Order.find(params[:id])
  end
end