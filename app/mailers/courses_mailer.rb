class CoursesMailer < ApplicationMailer
  def assign_to_course course, emails
    @course = course
    mail to: emails, subject: t("email.assign_email_title", title: course.name)
  end
end
