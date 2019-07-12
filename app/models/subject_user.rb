class SubjectUser < ApplicationRecord
  enum status: {init: 0, study: 1, done: 2}

  belongs_to :course_user
  belongs_to :subject
  has_many :progress_user_tasks, dependent: :destroy
end
