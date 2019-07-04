class ProgressUserTask < ApplicationRecord
  enum status: {init: 0, studying: 1, finish: 2}

  belongs_to :task
  belongs_to :subject_user
  scope :update_task, ->(subject_uid){where(subject_user_id: subject_uid).update_all(status: 2)}
  scope :get_stt, ->(subject_uid){where(subject_user_id: subject_uid).pluck :status}
end
