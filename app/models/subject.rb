class Subject < ApplicationRecord
  has_many :course_subjects, dependent: :destroy
  has_many :subject_tasks, dependent: :destroy
end
