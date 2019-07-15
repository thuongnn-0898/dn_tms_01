class Supervisors::SupervisorsController < ApplicationController
  before_action :load_users, only: %i(edit update)
  before_action :load_course, only: %i(edit update)

  def show; end

  def edit; end

  def update
    if @course.update_attributes course_user_params
      flash[:success] = t "messages.save_success"
      redirect_to supervisors_courses_path
    else
      flash[:danger] = t "messages.save_unsuccess"
      render :edit
    end
  end

  private

  def course_user_params
    pp = params.require(:course).permit :id, course_users_attributes:
      [:id, :course_id, :user_id, :role, :_destroy]
    pp[:course_users_attributes].each do |x|
      x[1][:role] = User.roles[:supervisor]
    end
    return pp




  end

  def load_users
    @users = User.supervisors.newest
  end

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:warning] = t "messages.course_not_found"
    redirect_to supervisors_courses_path
  end
end
