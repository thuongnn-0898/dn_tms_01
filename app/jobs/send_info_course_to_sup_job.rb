class SendInfoCourseToSupJob < ApplicationJob
  queue_as :default

  def perform(course_id)
    SendInfoCourseToSupMailer.send_mail(course_id)
  end
end
