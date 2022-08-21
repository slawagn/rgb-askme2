class User < ApplicationRecord
  has_secure_password

  before_validation { nickname.downcase! }
  before_validation { email.downcase! }

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
    format: { with: /#[0-9A-Z]{6}/i }, allow_nil: true
end
