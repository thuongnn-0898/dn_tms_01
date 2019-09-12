class AssignTraineeJob < ApplicationJob
  queue_as :default
  # action 1: assign, 2: remove
  def perform email, course, action
    if action == 1
      AssignMailer.send_mail(email, course)
    else
      RemoveTraineeMailer.send_mail(email, course)
    end
  end
end
