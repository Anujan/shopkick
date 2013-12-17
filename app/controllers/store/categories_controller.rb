class Store::CategoriesController < Store::BaseController
  def show
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(16)
    if request.xhr?
      render partial: "store/products/product_list", locals: { products: @products }
    end
  end
end