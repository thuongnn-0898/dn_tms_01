module Supervisors::TraineesHelper
  def display_gender gender
    if gender.male?
      "fa-male"
    elsif gender.female?
      "fa-female"
    else
      "fa-male"
    end
  end

  def exists_in_course? course_id, user_id
    # check = CourseUser.where(course_id: course_id,user_id: user_id).count
    check = CourseUser.byCourse_User(course_id, user_id).count
    check.positive?
  end
end
