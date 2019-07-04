class Course < ApplicationRecord

  enum status_types: {init: 0, start: 1, learning: 2, finish: 3}

  has_many :course_users, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
end
