class StoresController < ApplicationController
  def new
    @store = Store.new
  end

  def create
    @store = Store.new(params[:store])
    if @store.save
      flash.now[:success] = "Your store has been created!"
      log_in!(@store)
      redirect_to admin_root_url
    else
      flash.now[:error] = @store.errors.full_messages
      render :new
    end
  end

  def show
  end
end
