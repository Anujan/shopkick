class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :store_must_exist

  include UrlHelper
  include SessionsHelper
  include StoresHelper
  include ApplicationHelper
end
