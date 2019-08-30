class SendEmailEndOfMonthMailer < ApplicationMailer
  def self.send_mail
    @lists = CourseUser.includes(:user, :course).supervisor
    return puts "Course null" unless @list
    @lists.each do |course_user|
      @list_users = CourseUser.includes(:user).by_course_id(course_user.course_id)
      sendEveryEndOfMonth(course_user.email, course_user.course, @list_users).deliver
    end
  end

  def sendEveryEndOfMonth email, course, list_users
    @course = course
    @list_users = list_users
    mail(to: email, subject: t "mailer.end_of_month.subject" )
  end
end
