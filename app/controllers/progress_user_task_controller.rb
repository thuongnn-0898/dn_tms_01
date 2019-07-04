class ProgressUserTaskController < ApplicationController

  def finish_task
    ProgressUserTask.transaction do
      ProgressUserTask.find_by(id: params[:id_task]).update_attribute(:status, 2)
      @status = ProgressUserTask.get_stt params[:subject_user_id]
      # check finish all tasks?
      check = @status.include?("studying")
      return if check
      finish_subj_user params[:subject_user_id]
      respond_to do |format|
        format.js
        format.json{render json: "Success".to_json, status: 200}
      end
    end
    rescue
      respond_to do |format|
        format.js
        format.json{render json: "Fails".to_json, status: 500}
      end
  end

end
