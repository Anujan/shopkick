class Store::CartsController < Store::BaseController
  def show
  end

  def update
  	CartProduct.transaction do
	  	@cart.cart_products.each do |cp|
	  		quantity = params[:updates][cp.id.to_s]
	  		next if quantity.blank?
	  		quantity = quantity.to_i
	  		if quantity.zero?
	  			cp.destroy
	  		else
	  			cp.update_attribute(:quantity, quantity)
	  		end
	  		flash.now[:error] = cp.errors.full_messages if cp.invalid?
	  	end
  	end
  	render :show
  end

  def load_cart
  	super(Cart.includes(cart_products: { product: :images }))
  end
end