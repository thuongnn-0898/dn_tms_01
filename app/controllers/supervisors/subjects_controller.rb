class Supervisors::SubjectsController < ApplicationController
  before_action :logged_in_user, :is_supervisor?
  before_action :load_subject, only: [:edit, :update]
  def index
    @subjects = Subject.newest.paginate(per_page: Settings.per_page_default,
      page: params[:page])
  end

  def new
    @subject = Subject.new
    @subject.tasks.build
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "messages.save_success"
      redirect_to supervisors_subjects_path
    else
      flash[:danger] = t "messages.save_error"
      render :new
    end
  end

  def edit; end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "messages.update_success"
      redirect_to supervisors_subjects_path
    else
      render :edit
    end
  end

  private

  def subject_params
    params.require(:subject).permit :name, :description, :picture, tasks_attributes: [:id, :name, :subject_id, :_destroy]
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject.present?
  end

end
