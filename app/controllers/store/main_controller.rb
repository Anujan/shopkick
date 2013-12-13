class Store::MainController < Store::BaseController
  def index
    @featured_product = Product.order("RANDOM()").first
    @latest_products = Product.order("created_at DESC").take(3)
  end
end