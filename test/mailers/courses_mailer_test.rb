require 'test_helper'

class CoursesMailerTest < ActionMailer::TestCase
  def course_mail_preview
    CoursesMailer.assign_to_course(Course.first)
  end
end
