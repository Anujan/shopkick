class Admin::ProductsController < Admin::BaseController
  before_filter :current_product, only: [:edit, :update, :destroy, :show]

  def index
    @products = Product.order('created_at DESC')
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = "Product `#{@product.title}` has been created!"
      redirect_to admin_products_url
    else
      flash.now[:errors] = @product.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @product.update_attributes(params[:product])
      flash[:notice] = "Product `#{@product.title}` has been updated!".
      redirect_to admin_products_url
    else
      flash.now[:errors] = @product.errors.full_messsages
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = "Product `#{@product.title}` has been deleted!".
      redirect_to admin_products_url
    end
  end

  def current_product
    @product = Product.find(params[:id])
  end
end