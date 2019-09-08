class CourseUser < ApplicationRecord
  # Enums
  enum role: { trainee: 0, supervisor: 1}

  # Relationships
  belongs_to :user
  belongs_to :course
  has_many :subject_users, dependent: :destroy
  has_many :subjects, through: :subject_users

  delegate :fullname, :email, to: :user
  delegate :name, to: :course

  scope :byUser, ->(user_id){where user_id: user_id}
  scope :byCourse_User, ->(course_id, user_id){byCourseId(course_id).
    byUser(user_id)}
  scope :supervisors, ->{where role: CourseUser.roles[:supervisor]}

end
