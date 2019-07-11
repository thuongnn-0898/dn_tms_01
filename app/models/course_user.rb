class CourseUser < ApplicationRecord
  enum role_types: {trainee: 0, suppervisor: 1}

  belongs_to :user
  belongs_to :course
  has_many :subject_users, dependent: :destroy
  has_many :subjects, through: :subject_users
end
