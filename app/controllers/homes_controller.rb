class HomesController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find_by(id: current_user.id)
    @list_users = User.order_role.paginate(per_page: Settings.per_page_default,
      page: params[:page])
  end
end
