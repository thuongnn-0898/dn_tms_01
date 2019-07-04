class SubjectUsersController < ApplicationController
  after_action :check_finish_all_task, only: :finish_task

  def details_task
    @subj_user = SubjectUser.find_by(id: params[:subj_user_id])
    @progress_user_tasks = @subj_user.progress_user_tasks.includes(:task)
    @subject = @subj_user.subject
    @progress_user_task = []
    @progress_user_tasks.each do |task|
      @progress_user_task << {progress_user_id: task.id, name: task.task.name, status: task.status}
    end
    return render json: {} if @progress_user_task.blank?
    @result = [@subject, @progress_user_task]
    respond_to do |format|
      format.js
      format.json{render json: @result.to_json}
    end
  end

  def finish_subject
    subject_uid = params[:subj_user_id]
    SubjectUser.transaction do
      finish_subj_user(subject_uid)
      ProgressUserTask.update_task(subject_uid)
    end
    respond_to do |format|
      format.js
      format.json{render json: "Success".to_json, status: 200}
    end
  rescue ActiveRecord::RecordInvalid => exception
    respond_to do |format|
      format.js
      format.json{render json: "Fail".to_json, status: 500}
    end
  end

end
