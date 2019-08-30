class AssignTraineeJob < ApplicationJob
  queue_as :default
  # action 1: assign, 2: remove
  def perform agr1, agr2, action
    if action == 1
      AssignMailer.send_mail(agr1, agr2)
    else
      RemoveTraineeMailer.send_mail(agr1, agr2)
    end
  end
end
