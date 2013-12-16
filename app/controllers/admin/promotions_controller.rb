class Admin::PromotionsController < Admin::BaseController
  before_filter :current_promotion, only: [:edit, :update, :destroy, :show]

  def index
    @promotions = Promotion.order('created_at DESC')
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(params[:promotion])
    if @promotion.save
      flash[:notice] = "Promotion ##{@promotion.code} has been created!"
      redirect_to admin_promotions_url
    else
      flash.now[:errors] = @promotion.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @promotion.update_attributes(params[:promotion])
      flash[:notice] = "Promotion ##{@promotion.code} has been updated!"
      redirect_to admin_promotions_url
    else
      flash.now[:errors] = @promotion.errors.full_messsages
      render :edit
    end
  end

  def destroy
    if @promotion.destroy
      flash[:notice] = "Promotion ##{@promotion.code} has been deleted!"
      redirect_to admin_promotions_url
    end
  end

  def current_promotion
    @promotion = Promotion.find(params[:id])
  end
end