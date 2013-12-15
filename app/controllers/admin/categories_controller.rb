class Admin::CategoriesController < Admin::BaseController
  before_filter :current_category, only: [:edit, :update, :destroy, :show]

  def index
    @categories = Category.order('created_at DESC')
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = "Category `#{@category.title}` has been created!"
      redirect_to admin_categories_url
    else
      flash.now[:errors] = @category.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @category.update_attributes(params[:category])
      flash[:notice] = "Category `#{@category.title}` has been updated!"
      redirect_to admin_categories_url
    else
      flash.now[:errors] = @category.errors.full_messsages
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = "Category `#{@category.title}` has been deleted!"
      redirect_to admin_categories_url
    end
  end

  def current_category
    @category = Category.find(params[:id])
  end
end