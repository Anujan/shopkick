class Admin::CustomersController < Admin::BaseController
  before_filter :current_customer, only: [:edit, :update, :destroy, :show]

  def index
    @customers = Customer.order('created_at DESC')
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      flash[:notice] = "Customer `#{@customer.full_name}` has been created!"
      redirect_to admin_customers_url
    else
      flash.now[:errors] = @customer.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @customer.update_attributes(params[:customer])
      flash[:notice] = "Customer `#{@customer.full_name}` has been updated!"
      redirect_to admin_customers_url
    else
      flash.now[:errors] = @customer.errors.full_messsages
      render :edit
    end
  end

  def destroy
    if @customer.destroy
      flash[:notice] = "Customer `#{@customer.full_name}` has been deleted!"
      redirect_to admin_customers_url
    end
  end

  def current_customer
    @customer = Customer.find(params[:id])
  end
end