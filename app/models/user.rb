class User < ApplicationRecord
  DEFAULT_HEADER_COLOR = '#370617'

  has_many :questions, dependent: :delete_all

  attribute :header_color, default: DEFAULT_HEADER_COLOR
  has_secure_password

  before_validation { nickname.downcase! }
  before_validation { email.downcase! }

  validates :name,
    presence: true,
    length: { maximum: 40 }

  validates :email,
    presence:   true,
    uniqueness: true,
    format:     { with: URI::MailTo::EMAIL_REGEXP }

  validates :nickname,
    presence:   true,
    uniqueness: true,
    format:     { with: /\A[a-zA-Z0-9_]+\Z/ },
    length:     { minimum: 4, maximum: 40 }

  validates :header_color,
    presence: true,
    format: { with: /\A#[[:xdigit:]]{3}{1,2}\Z/ }
end
