class SubjectUser < ApplicationRecord

  enum status_types: {init: 0, study: 1, done: 2}

  belongs_to :course_user
  belongs_to :course_subject
  has_many :progress_user_tasks, dependent: :destroy
end
