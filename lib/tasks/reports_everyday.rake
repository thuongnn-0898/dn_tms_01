namespace :reports_everyday do
  desc "reports_everyday"
  task reports_everyday: :environment do
    SendReportMailer.send_mail
  end
end
