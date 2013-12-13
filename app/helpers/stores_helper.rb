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
end
