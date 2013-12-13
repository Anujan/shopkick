class Store::ProductsController < Store::BaseController
  before_filter :current_product, only: [:show]

  def index
    @products = Product.all
  end

  def show
  end

  def current_product
    @product ||= Product.find(params[:id])
  end
end