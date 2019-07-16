class MailWorker
  include Sidekiq::Worker

  def perform name, course,user_emails
    case name
    when "sendmail"
      CoursesMailer.assign_to_course(course, user_emails).deliver_now
    else
      return
    end
  end

  def destroy_jobs user_id, point
    jobs = Sidekiq::ScheduledSet.new.select do |retri|
      retri.klass == self.class.name && retri.item["args"] == [user_id, point]
    end
    jobs.each(&:delete)
  end
end
