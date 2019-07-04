class HomesController < ApplicationController
  before_action :logged_in_user, :is_trainee?

  def index
    @users = User.order_role.paginate(per_page: Settings.per_page_default,
      page: params[:page])
  end
end
