class Store::ProductsController < Store::BaseController
  before_filter :current_product, only: [:show]

  def index
    @products = Product.where(visible: true).page(params[:page]).per(16)
    if request.xhr?
      render partial: "product_list", locals: { products: @products }
    else
      render :index
    end
  end

  def show
  end

  def update
    products = CartProduct.find_by_cart_and_product_slug(@cart.id, params[:id])
    if products.empty?
      @cart.cart_products.create(product: Product.find(params[:id]))
    else
      products.first.add_quantity
    end
    flash[:notice] = "Your cart has been updated!"
    redirect_to :back
  end

  def destroy
    order_product = CartProduct.find_by_cart_and_product_slug(@cart.id, params[:id])
    if order_product.first
      flash[:notice] = "#{order_product.first.title} has been removed from your cart."
      order_product.first.destroy
    end
    redirect_to cart_path
  end

  def current_product
    @product ||= Product.find(params[:id])
  end
end