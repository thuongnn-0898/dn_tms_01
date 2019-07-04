class ProgressUserTask < ApplicationRecord

  enum status_types: {init: 0, start: 1, learning: 2, finish: 3}

  belongs_to :subject_task
  belongs_to :subject_user
end
