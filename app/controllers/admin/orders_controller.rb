class Admin::OrdersController < Admin::BaseController
  before_filter :current_order, only: [:edit, :update, :destroy, :show]
  respond_to :html, :json

  def index
    respond_with(@orders = Order.includes(:products).order('created_at DESC'))
  end

  def new
    respond_with(@order = Order.new)
  end

  def create
    @order = Order.new(params[:order])
    if @order.save
      flash[:notice] = "Order ##{@order.id} has been created!"
      respond_with do |format|
        format.html { redirect_to admin_orders_url }
        format.json { render json: @order }
      end
    else
      flash.now[:errors] = @order.errors.full_messages
      respond_with do |format|
        format.html { render :new }
        format.json { render json: @order.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
  end

  def update
    if @order.update_attributes(params[:order])
      flash[:notice] = "Order ##{@order.id} has been updated!"
      respond_with do |format|
        format.html { redirect_to admin_orders_url }
        format.json { render json: @order }
      end
    else
      flash.now[:errors] = @order.errors.full_messsages
      respond_with do |format|
        format.html { render :edit }
        format.json { render json: @order.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @order.destroy
      flash[:notice] = "Order ##{@order.id} has been deleted!"
      respond_with do |format|
        format.json { head :ok }
        format.html { redirect_to admin_orders_url }
      end
    end
  end

  def current_order
    @order = Order.find(params[:id])
  end
end