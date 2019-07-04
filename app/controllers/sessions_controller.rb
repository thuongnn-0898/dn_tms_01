class SessionsController < ApplicationController
  before_action :logined?, only: :new

  def new; end

  def create
    user = User.find_by(email: params[:account][:email])
    if user&.authenticate(params[:account][:password])
      login user
      flash[:warning] = t("session.login_msg", email: user.email)
      redirect_to profile_path
    else
      flash[:danger] = t("session.login_fail")
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    flash[:success] = t "session.logout_msg"
    redirect_to root_path
  end
end
