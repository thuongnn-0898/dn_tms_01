class CourseUser < ApplicationRecord
  # Enums
  enum role: {trainee: 0, supervisor: 1}

  # Relationships
  belongs_to :user
  belongs_to :course
  has_many :subject_users, dependent: :destroy
  has_many :subjects, through: :subject_users
end
