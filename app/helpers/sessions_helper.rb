module SessionsHelper
  def current_store
    return nil if cookies.signed[:token].nil?
    sess = Session.find_by_token(cookies.signed[:token])
    if !!@current_store && sess
      @current_store ||= sess.store
    end
    @current_store
  end

  def signed_in?
    !!current_store
  end

  def log_in!(store, remember_me=false)
    unless cookies.signed[:token].nil?
      logout!
    end

    sess = store.sessions.create(ip_address: request.ip, user_agent: request.env['HTTP_USER_AGENT'])
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
end
