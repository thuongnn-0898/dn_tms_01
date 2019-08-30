class SendReportMailer < ApplicationMailer
  def self.send_mail
    supervisors = User.supervisors.pluck(:email, :fullname)
    reports = Report.includes(:user).all
    supervisors.each do |email|
      sendReports(email[0], reports, email[1]).deliver
    end
  end

  def sendReports email, reports, name
    @name = name
    @reports = reports
    mail(to: email, subject: "Reports to day")
  end
end
