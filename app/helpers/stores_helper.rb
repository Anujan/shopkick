module StoresHelper
  def current_store
    @current_store ||= Store.find_by_name(request.subdomain)
  end
end
