class Store::MainController < Store::BaseController
  def index
    @featured_product = Product.where(visible: true).order("RANDOM()").first
    @latest_products = Product.where(visible: true).order("created_at DESC").take(4)
  end
end