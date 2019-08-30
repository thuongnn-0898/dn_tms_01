class Report < ApplicationRecord
    belongs_to :user

    validates :title, presence: true
    validates :content, presence: true

    delegate :fullname, :email, to: :user

    def self.check_report_today
        return self.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).any?
    end
end
