module StoresHelper
  def current_store
    subdomain = request.subdomain.sub('www.', '')

    @current_store ||= Store.find_by_name(subdomain)
  end

  def store_must_exist
  	if !current_store && !request.subdomain.blank?
      flash[:error] = "The store you're looking for doesn't seem to exist"
  		redirect_to root_url(subdomain: false)
  	elsif current_store
  		Apartment::Database.switch(current_store.name)
  	end
  end

  def load_cart
    cart_id = cookies.signed[:cart_id]
    puts "Cart ID: #{cart_id}"
    unless cart_id.nil?
      @cart ||= Cart.find_by_id(cart_id)
    end
    unless @cart.nil?
      @cart.update_attributes(last_accessed: Time.now)
    else
      @cart = Cart.create!(last_accessed: Time.now)
      cookies.permanent.signed[:cart_id] = @cart.id
    end
  end
end
