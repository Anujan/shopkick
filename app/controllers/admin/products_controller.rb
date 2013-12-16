class Admin::ProductsController < Admin::BaseController
  before_filter :current_product, only: [:edit, :update, :destroy, :show]
  respond_to :json, :html

  def index
    respond_with(@products = Product.includes(:images).order('created_at DESC'))
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      respond_with do |format|
        format.html do
          flash[:notice] = "Product `#{@product.title}` has been created!"
          redirect_to admin_products_url
        end
        format.json { render json: @product }
      end

    else
      respond_with do |format|
        format.html do
          flash.now[:errors] = @product.errors.full_messages
          render :new
        end
        format.json { render json: @product.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
  end

  def update
    if @product.update_attributes(params[:product])
      flash[:notice] = "Product `#{@product.title}` has been updated!"
      respond_with do |format|
        format.html { redirect_to admin_products_url }
        format.json { render json: @product }
      end
    else
      respond_with do |format|
        format.html do
          flash.now[:errors] = @product.errors.full_messages
          render :edit
        end
        format.json { render json: @product.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @product.destroy
      respond_with do |format|
        format.html do
          flash[:notice] = "Product `#{@product.title}` has been deleted!"
          redirect_to admin_products_url
        end
        format.json { head :ok }
      end
    end
  end

  def current_product
    @product = Product.find(params[:id])
  end
end