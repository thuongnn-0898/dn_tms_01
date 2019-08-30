class SendEmailEndOfMonthMailer < ApplicationMailer
  def self.send_mail
    @list = CourseUser.includes(:user, :course).supervisor
    return puts "Course null" unless @list
    @list.each do |email|
      sendEveryEndOfMonth(email.email).deliver
    end
  end

  def sendEveryEndOfMonth email
    mail(to: email, subject: "Notification end of month", from: "admin@gmail.com")
  end
end
