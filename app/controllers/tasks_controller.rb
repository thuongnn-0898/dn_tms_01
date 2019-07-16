class TasksController < ApplicationController

  def show
    @tasks = Task.where(subject_id: params[:subject_id])
    respond_to do |format|
      format.js
      format.json{render json: @tasks.to_json}
    end
  end

end
