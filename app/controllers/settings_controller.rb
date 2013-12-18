class SettingsController < ApplicationController
  respond_to :json, :html

  def show
    respond_with(@profile = Profile.first)
  end

  def edit
    respond_with(@profile = Profile.first)
  end

  def update
    @profile = Profile.first
    if @profile.update_attributes(params[:profile])
      respond_with do |format|
        format.html { redirect_to new_admin_setting }
        format.json { render json: @profile }
      end
    else
      respond_with do |format|
        format.html { flash.now[:errors] = @order.errors.full_messsages; render :new }
        format.json { render json: @order.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end
end
