module StoresHelper
  def current_store
    subdomain = request.subdomain.sub('www.', '')

    # Testing purposes with xip.io
    subdomain = subdomain.sub('.127.0.0.1', '')


    @current_store ||= Store.find_by_name(subdomain)
  end
end
