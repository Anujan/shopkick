class StoresController < ApplicationController
  def new
    @store = Store.new
  end

  def create
    @store = Store.new(params[:store])
    if @store.save
      flash[:success] = "Your store has been created!"
      log_in!(@store)
      redirect_to admin_root_url(subdomain: @store.name)
    else
      flash[:error] = @store.errors.full_messages
      redirect_to :back
    end
  end

  def show
  end
end
