class Supervisors::SupervisorsController < ApplicationController
  before_action :load_users, only: %i(edit update)
  before_action :load_course, only: %i(edit update)
  before_action :check_valid_date, only: %i(edit update)

  def show; end

  def edit; end

  def update
    if @course.update_attributes course_user_params
      lst_new_trainees = course_user_params[:course_users_attributes].values.select{|item| item[:id].nil? }
      user_ids = lst_new_trainees.map{|item| item[:user_id].to_i}
      user_emails = User.user_emails user_ids
      if user_emails.length > 0
        # MailWorker.perform_at(Time.zone.now + 10.second, "sendmail", user_emails)
        CoursesMailer.assign_to_course(@course, user_emails).deliver_now
      end

      flash[:success] = t "messages.save_success"
      redirect_to supervisors_courses_path
    else
      flash[:danger] = t "messages.save_unsuccess"
      render :edit
    end
  end

  private

  def course_user_params
    user_params = params.require(:course).permit :id, course_users_attributes:
      [:id, :course_id, :user_id, :role, :_destroy]
    user_params[:course_users_attributes].each do |x|
      x[1][:role] = User.roles[:supervisor]
    end
    return user_params
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

  def check_valid_date
    if @course.date_end < Date.today
      flash[:danger] = t "messages.course_expired"
      redirect_to supervisors_courses_path
    end
  end
end
