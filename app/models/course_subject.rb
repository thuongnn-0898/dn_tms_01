class CourseSubject < ApplicationRecord
  enum status: {init: 0, learning: 1, finish: 2}

  belongs_to :course
  belongs_to :subject
end
