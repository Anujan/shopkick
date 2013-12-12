module StoresHelper
  def current_store
    subdomain = request.subdomain.sub('www.', '')

    # Testing purposes with xip.io
    subdomain = subdomain.sub('.127.0.0.1', '')


    @current_store ||= Store.find_by_name(subdomain)
  end

  def store_must_exist
  	if !current_store && !request.subdomain.blank?
  		redirect_to root_url(subdomain: false)
  	elsif current_store
  		Apartment::Database.switch(current_store.name)
  	end
  end
end
