class Store::ProductsController < Store::BaseController
  def index
    @products = Product.all
  end
end