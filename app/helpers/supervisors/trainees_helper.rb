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
    check = CourseUser.byCourse_User(course_id, user_id).size
    check.positive?
  end

  def infomation_this_course_user id
    return Course.find_by id: id
  end
end
