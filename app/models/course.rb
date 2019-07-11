class Course < ApplicationRecord
  enum status_types: {init: 0, start: 1, learning: 2, finish: 3}
  enum duration_types: {hour: 0, day: 1, month: 2}

  has_many :course_users, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
end
