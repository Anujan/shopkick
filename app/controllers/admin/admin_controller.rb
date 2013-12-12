class Admin::AdminController < ApplicationController
  before_filter :require_current_admin!

  def dashboard
  end
end
