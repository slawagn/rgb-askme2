class User < ApplicationRecord
  has_secure_password

  enum :header_color, { red: 0, orange: 1, blue: 2, pink: 3 }

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
end
