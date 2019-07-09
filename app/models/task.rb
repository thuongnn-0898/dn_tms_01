class Task < ApplicationRecord
  has_many :subject_tasks, dependent: :destroy
end
