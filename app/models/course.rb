class Course < ApplicationRecord
  # Enums
  enum status: {init: 0, start: 1, finish: 2}
  enum duration_type: {hour: 0, day: 1, month: 2}

  # Relationships
  has_many :course_users, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
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
  validates :date_start, presence: true, allow_nil: true, on: :update
  validates :date_end, presence: true

  before_validation :check_start_valid, on: [:create]
  before_validation :check_end_valid, on: [:create, :update]

  validate do
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
        Course.duration_types.map do |k, _v|
          [I18n.t("course.duration_type.#{k}"), k]
        end
      ]
    end

    def status_i18n
      Hash[Course.statuses.map{|k, _v| [I18n.t("course.status.#{k}"), k]}]
    end
  end

  private

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

  def check_start_valid
    return if date_start.nil? || date_end.nil?
    return if date_start.to_date >= Date.today && date_start <= date_end
    errors.add(:date_start, :date_start_must_be_large_than_today)
  end

  def check_end_valid
    return if date_start.nil? || date_end.nil?
    return if date_end.to_date >= date_start
    errors.add(:date_end, :date_end_must_be_equal_large_than_date_start)
  end
end
