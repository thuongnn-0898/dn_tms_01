module SessionsHelper
  def login user
    session[:user_id] = user.id
  end

  def current_user
    @current_user = User.find_by id: session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def logined?
    return unless logged_in?
    if current_user.trainee?
      redirect_to home_path
    else
      redirect_to supervisors_users_path
    end
  end

  def is_trainee?
    return if current_user.present? && current_user.trainee?
    redirect_to login_path
  end

  def is_supervisor?
    return if current_user.present? && current_user.supervisor?
    redirect_to login_path
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
    flash[:success] = t "session.logout_msg"
    redirect_to root_path
  end
end
