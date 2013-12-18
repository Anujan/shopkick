class Store::CategoriesController < Store::BaseController
  def show
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(16)
    if request.xhr?
      if params[:infinite]
        render partial: "store/products/product_list", locals: { products: @products }
      else
        render :show, layout: false
      end
    end
  end
end