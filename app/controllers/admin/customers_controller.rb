class Admin::CustomersController < Admin::BaseController
  before_filter :current_customer, only: [:edit, :update, :destroy, :show]
  respond_to :json, :html

  def index
    respond_with(@customers = Customer.order('created_at DESC'))
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      respond_with do |format|
        format.html do
          flash[:notice] = "Customer `#{@customer.full_name}` has been created!"
          redirect_to admin_customers_url
        end
        format.json { render json: @customer }
      end

    else
      respond_with do |format|
        format.html do
          flash.now[:errors] = @customer.errors.full_messages
          render :new
        end
        format.json { render json: @customer.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
  end

  def update
    if @customer.update_attributes(params[:customer])
      flash[:notice] = "Customer `#{@customer.full_name}` has been updated!"
      respond_with do |format|
        format.html { redirect_to admin_customers_url }
        format.json { render json: @customer }
      end
    else
      respond_with do |format|
        format.html do
          flash.now[:errors] = @customer.errors.full_messages
          render :edit
        end
        format.json { render json: @customer.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @customer.destroy
      respond_with do |format|
        format.html do
          flash[:notice] = "Customer `#{@customer.full_name}` has been deleted!"
          redirect_to admin_customers_url
        end
        format.json { head :ok }
      end
    end
  end

  def current_customer
    @customer = Customer.find(params[:id])
  end
end