class Admin::CategoriesController < Admin::BaseController
  before_filter :current_category, only: [:edit, :update, :destroy, :show]
  respond_to :json, :html

  def index
    respond_with(@categories = Category.includes(:products).order('created_at DESC'))
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      respond_with do |format|
        format.html do
          flash[:notice] = "Category `#{@category.title}` has been created!"
          redirect_to admin_categories_url
        end
        format.json { render json: @category }
      end

    else
      respond_with do |format|
        format.html do
          flash.now[:errors] = @category.errors.full_messages
          render :new
        end
        format.json { render json: @category.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
  end

  def update
    if @category.update_attributes(params[:category])
      flash[:notice] = "Category `#{@category.title}` has been updated!"
      respond_with do |format|
        format.html { redirect_to admin_categories_url }
        format.json { render json: @category }
      end
    else
      respond_with do |format|
        format.html do
          flash.now[:errors] = @category.errors.full_messages
          render :edit
        end
        format.json { render json: @category.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @category.destroy
      respond_with do |format|
        format.html do
          flash[:notice] = "Category `#{@category.title}` has been deleted!"
          redirect_to admin_categories_url
        end
        format.json { head :ok }
      end
    end
  end

  def current_category
    @category = Category.find(params[:id])
  end
end