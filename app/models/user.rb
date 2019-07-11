class User < ApplicationRecord
  enum role_types: {trainee: 0, suppervisor: 1}
  enum gender_types: {male: 1, female: 0}

  has_many :course_users, dependent: :destroy
  has_many :courses, through: :course_users

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

  mount_uploader :avatar, PictureUploader

  has_secure_password

  scope :newest, ->{order id: :desc}

  class << self
    def role_types_i18n
      Hash[User.role_types.map{|k, v| [I18n.t("user.role.#{k}"), v]}]
    end

    def gender_types_i18n
      Hash[User.gender_types.map{|k, v| [I18n.t("user.gender.#{k}"), v]}]
    end
  end
end
