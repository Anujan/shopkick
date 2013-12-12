class Admin::BaseController < ApplicationController
  before_filter :require_current_admin!
  layout 'admin'
end