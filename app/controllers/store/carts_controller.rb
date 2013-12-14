class Store::CartsController < Store::BaseController
  def show
  end

  def update
  	CartProduct.transaction do
	  	@cart.cart_products.each do |cp|
	  		quantity = params[:updates][cp.id.to_s]
	  		next if quantity.blank?
	  		cp.update_attribute(:quantity, quantity.to_i)
	  		flash.now[:error] = cp.errors.full_messages if cp.invalid?
	  	end
  	end
  	render :show
  end
end