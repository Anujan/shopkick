class Store::BaseController < ApplicationController
  before_filter :load_cart

  layout 'store'
end