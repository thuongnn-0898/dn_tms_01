class Task < ApplicationRecord
  belongs_to :subject
  has_many :progress_user_tasks, dependent: :destroy

  validates :name, presence: true,
            length: {maximum: Settings.name_length_maximum}
end
