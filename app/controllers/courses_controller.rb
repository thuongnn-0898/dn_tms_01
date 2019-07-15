class CoursesController < ApplicationController
  before_action :load_course, only: :show
  def index
    @courses = Course.by_status.paginate(per_page: Settings.per_page_default,
      page: params[:page])
  end

  def show
    @subjects = @course.subject
  end

  private

  def load_course
    @course = Course.includes(:subject).find_by(id: params[:id])
    return if @course
    render html: "NOT FOUND"
  end

end
