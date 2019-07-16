class Course < ApplicationRecord
  # Enums
  enum status: {init: 0, start: 1, finish: 2}
  enum duration_type: {hour: 0, day: 1, month: 2}

  # Relationships
  has_many :course_users, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :users, through: :course_users

  # Nested attribute
  accepts_nested_attributes_for :course_users, allow_destroy: true
  accepts_nested_attributes_for :course_subjects, allow_destroy: true

  # Validates
  validates :name, presence: true,
    length: {maximum: Settings.name_length_maximum}
  validates :description, presence: true,
    length: {maximum: Settings.content_text_max_length}
  validates :duration, presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: Settings.duration_minimun,
      less_than_or_equal_to: Settings.duration_maximum
    }

  # Custom validates
  validate do
    check_dates_valid
    check_number_of_course_subject
    check_duplicate_of_course_subject
  end

  # Uploader
  mount_uploader :picture, PictureUploader

  # Query options
  scope :newest, ->{order id: :desc}

  class << self
    def duration_type_i18n
      Hash[
        Course.duration_types.map{|k, v| [I18n.t("course.duration_type.#{k}"), k]}
      ]
    end

    def status_i18n
      Hash[Course.statuses.map{|k, v| [I18n.t("course.status.#{k}"), k]}]
    end
  end

  private

  def check_dates_valid
    if date_start < Date.today
      errors.add(:date_start, :date_start_must_be_large_than_today)
    elsif date_end < date_start
      errors.add(:date_end, :date_end_must_be_equal_large_than_date_start)
    end
  end

  def course_subject_count_valid?
    course_subjects.reject(&:marked_for_destruction?).count >= 1
  end

  def course_subject_duplicate_valid?
    course_subjects.group_by(&:subject_id).count == course_subjects.length
  end

  def check_number_of_course_subject
    return if course_subject_count_valid?
    errors.add(:course_subjects, :course_subjects_too_short, count: 1)
  end

  def check_duplicate_of_course_subject
    return if course_subjects.present? && course_subject_duplicate_valid?
    errors.add(:course_subjects, :course_subjects_duplicate_subject)
  end
end
