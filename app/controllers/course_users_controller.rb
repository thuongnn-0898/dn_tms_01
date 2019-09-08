class CourseUsersController < ApplicationController
    before_action :load_course, only: :show
    def show;  end

    private

    def load_course
        @course = Course.includes(:subjects).find_by(id: params[:id])
        return if @course.present?
        flash[:danger] = t "messages.not_found"
        redirect_to home_path
    end
end
