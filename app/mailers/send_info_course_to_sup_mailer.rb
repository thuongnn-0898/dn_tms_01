class SendInfoCourseToSupMailer < ApplicationMailer

  def self.send_mail course_id
    supervisors = User.supervisor.pluck(:email, :fullname)
    course = Course.find(course_id)
    supervisors.each do |email|
      sendMailToSup(email[0], course, email[1]).deliver
    end
  end

  def sendMailToSup email, course, name
    @name = name
    @course = course
    mail(to: email, subject: "Notification about course")
  end
end
