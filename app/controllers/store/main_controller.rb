class Store::MainController < Store::BaseController
  def index
    @featured_product = Product.where(visible: true).order("RANDOM()").first
    @latest_products = Product.where(visible: true).order("created_at DESC").take(4)
    if request.xhr?
      render :index, layout: false
    else
      render :index
    end
  end
end