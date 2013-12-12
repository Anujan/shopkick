module SessionsHelper
  def current_admin
    return nil if cookies.signed[:token].nil?
    sess = Session.find_by_token(cookies.signed[:token])
    if sess
      @current_admin ||= sess.store
    end
    @current_admin
  end

  def signed_in?
    !!current_admin
  end

  def log_in!(store, remember_me=false)
    if signed_in?
      logout!
    end

    sess = store.sessions.create(ip_address: request.ip, user_agent: request.env['HTTP_USER_AGENT'])
    puts sess.token
    remember_cookie = { value: sess.token }
    if remember_me
      remember_cookie[:expires] = 30.days.from_now
    end

    cookies.signed[:token] = remember_cookie
  end

  def logout!
    Session.find_by_token(cookies.signed[:token]).destroy
    cookies.signed[:token] = nil
  end

  def require_current_admin!
    unless signed_in?
      redirect_to sign_in_url
    end
  end
end
