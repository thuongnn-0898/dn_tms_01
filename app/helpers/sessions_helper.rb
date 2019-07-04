module SessionsHelper
  def login user
    session[:user_id] = user.id
  end

  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def logined?
    return unless logged_in?
    if current_user.trainee?
      redirect_to profile_path
    else
      redirect_to profile_path
    end
  end
end
