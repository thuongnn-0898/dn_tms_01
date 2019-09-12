class AssignMailer < ApplicationMailer
  def self.send_mail emails, course
    emails.each do |email|
      sendMailMembers(email[0], course, email[1]).deliver
    end
  end

  def sendMailMembers email, course, name
    @name = name
    @course = Course.includes(:subjects).find_by id: course
    mail(to: email, subject: t("mailer.title.assign"))
  end
end
