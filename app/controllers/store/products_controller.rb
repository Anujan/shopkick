class Store::ProductsController < Store::BaseController
  before_filter :current_product, only: [:show]

  def index
    @products = Product.where(visible: true)
  end

  def show
  end

  def current_product
    @product ||= Product.find(params[:id])
  end
end