module SessionsHelper

  def log_in(member)
    session[:member_id] = member.id
  end

  def log_out
    forget(current_member)
    session.delete(:member_id)
  end

  def current_member
    if session[:member_id]
      @current_member ||= Member.find_by(id: session[:member_id])
    elsif cookies.signed[:member_id] 
      member = Member.find_by(id: cookies.signed[:member_id])
      if member && member.authenticated?(:remember, cookies[:remember_token])
        log_in member
        @current_member = member
      end
    end
  end

  def logged_in?
    !current_member.nil?
  end

  def remember(member)
    member.remember
    cookies.permanent[:remember_token] = member.remember_token
    cookies.permanent[:member_id] = member.id
  end

  def forget(member)
    member.forget
    cookies.delete(:remember_token)
    cookies.delete(:member_id)
  end

end
