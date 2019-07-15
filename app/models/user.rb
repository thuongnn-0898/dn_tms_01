class User < ApplicationRecord
  # Enums
  enum role: {trainee: 0, supervisor: 1}
  enum gender: {male: 1, female: 0}

  # Relationships
  has_many :course_users, dependent: :destroy
  has_many :courses, through: :course_users

  # Validates
  validates :fullname, presence: true,
    length: {maximum: Settings.fullname_length_maximum}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {minimum: Settings.email_length_minimum,
             maximum: Settings.email_length_maximum},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: Settings.password_length_minimum},
    allow_nil: true

  # Uploader
  mount_uploader :avatar, PictureUploader

  # Hash password
  has_secure_password

  # Query options
  scope :newest, ->{order id: :desc}
  scope :trainees, ->{where role: User.roles[:trainee]}
  scope :supervisors, ->{where role: User.roles[:supervisor]}
  scope :order_role, ->{order role: :desc}

  class << self
    def role_types_i18n
      Hash[User.role.map{|k, v| [I18n.t("user.role.#{k}"), v]}]
    end

    def gender_types_i18n
      Hash[User.gender.map{|k, v| [I18n.t("user.gender.#{k}"), v]}]
    end
  end
end
