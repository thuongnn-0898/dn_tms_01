module GlobalModule
  extend ActiveSupport::Concern

  included do
    scope :init, ->{where status: init}
    scope :studying, ->{where status: studying}
    scope :finish, ->{where status: finish}
    scope :orderStatus, ->{order(status: :desc)}
    scope :byCourseId, ->(course_id){where course_id: course_id}
  end
end
