module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  def current_user
    if session[:user_id]
  		if session[:user_type] == "lender"
  			return Lender.find(session[:user_id])
  		else
  			return Borrower.find(session[:user_id])
  		end
  	end
  	return nil
  end
  def logged_in?
      !current_user.nil?
  end
  def log_out
      session.delete(:user_id)
      @current_user = nil
  end
  def current_user?(user)
      user == current_user
  end
  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
      session[:forwarding_url] = request.url if request.get?
  end
end
