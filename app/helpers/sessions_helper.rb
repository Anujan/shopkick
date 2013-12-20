module SessionsHelper
  def current_admin
    return nil if session[:token].nil? && cookies.signed[:remember_token].nil?
    sess = Session.find_by_token(session[:token] || cookies.signed[:remember_token])
    if sess
      @current_admin ||= sess.store
    end
    @current_admin
  end

  def signed_in?
    !!current_admin
  end

  def log_in!(store, remember_me=false)
    sess = store.sessions.create(ip_address: request.ip, user_agent: request.env['HTTP_USER_AGENT'])
    remember_cookie = { value: sess.token, domain: :all }
    if remember_me
      remember_cookie[:expires] = 30.days.from_now
    end
    cookies.signed[:remember_token] = remember_cookie
    session[:token] = sess.token
  end

  def logout!
    sess = Session.find_by_token(cookies.signed[:remember_token])
    if sess
      sess.destroy
      cookies.delete :remember_token, domain: :all
      session[:token] = nil
    end
  end

  def require_current_admin!
    unless signed_in? && current_admin == current_store
      redirect_to sign_in_url(subdomain: false)
    end
  end
end
