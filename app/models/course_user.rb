class CourseUser < ApplicationRecord

  enum role_types: {trainee: 0, suppervisor: 1}
  enum status_types: {init: 0, start: 1, processing: 2, finish: 3}

  belongs_to :user
  belongs_to :course
  has_many :subject_users, dependent: :destroy
end
