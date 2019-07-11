class ProgressUserTask < ApplicationRecord
  belongs_to :task
  belongs_to :subject_user
end
