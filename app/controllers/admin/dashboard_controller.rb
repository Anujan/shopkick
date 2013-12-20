class Admin::DashboardController < Admin::BaseController
  respond_to :json, :html

  def index
    respond_with do |format|
      format.html { render :index }
      format.json { render json: Order.group("DATE(created_at)").select("DATE(created_at), sum(price) as total_price").order("DATE(created_at)") }
    end
  end
end