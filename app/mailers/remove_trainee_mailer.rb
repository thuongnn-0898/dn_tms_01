class RemoveTraineeMailer < ApplicationMailer
  def self.send_mail email, course_id
    removeTrainee(email, course_id).deliver
  end

  def removeTrainee email, course_id
    @course = Course.find_by id: course_id
    mail(to: email, subject: t("mailer.title.assign"))
  end
end
