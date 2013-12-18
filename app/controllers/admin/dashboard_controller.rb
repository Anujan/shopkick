class Admin::DashboardController < Admin::BaseController
  respond_to :json, :html

  def index
    respond_with do |format|
      format.html { render :index }
      format.json { render json: Order.group("date(created_at)").select("date(created_at), sum(price) as total_price") }
    end
  end
end