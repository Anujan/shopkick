class StoresController < ApplicationController
  def new
    @store = Store.new
  end

  def create
    @store = Store.new(params[:store])
    if @store.save
      flash.now[:success] = "Your store has been created!"
      redirect_to root_url #TODO: Change to admin URL
    else
      flash.now[:error] = @store.errors.full_messages
      render :new
    end
  end
end
