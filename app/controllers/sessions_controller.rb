class SessionsController < ApplicationController
  def new
    @store = Store.new
  end

  def create
    remember_me = !!params[:remember_me]
    credentials = params[:store].values
    @store = Store.find_by_credentials(*credentials)
    if @store
      log_in!(@store, remember_me)
      redirect_to admin_root_url(subdomain: @store.name)
    else
      flash.now[:error] = 'Invalid Credentials'
      render :new
    end
  end

  def destroy
    logout!
    redirect_to root_url
  end
end
