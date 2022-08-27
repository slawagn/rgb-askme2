class User < ApplicationRecord
  include Gravtastic
  
  DEFAULT_HEADER_COLOR = '#370617'

  attribute :header_color, default: DEFAULT_HEADER_COLOR
  has_secure_password
  gravtastic(secure: true, filetype: :png, size: 100, default: 'retro')

  scope :latest, -> { order(created_at: :desc) }

  has_many :questions_received,
    class_name:  'Question',
    foreign_key: 'user_id',
    dependent:   :delete_all

  has_many :questions_created,
    class_name:  'Question',
    foreign_key: 'author_id',
    dependent:   :nullify

  before_validation { downcase!(nickname) }
  before_validation { downcase!(email) }

  validates :name,
    presence: true,
    length: { maximum: 40 }

  validates :email,
    uniqueness: true,
    format:     { with: URI::MailTo::EMAIL_REGEXP }

  validates :nickname,
    uniqueness: true,
    length:     { minimum: 4, maximum: 40 },
    format:     { with: /\A[a-zA-Z0-9_]+\Z/ }

  validates :header_color,
    presence: true,
    format: { with: /\A#[[:xdigit:]]{3}{1,2}\Z/ }

  private

  def downcase!(string)
    string.downcase! if string.is_a? String
  end
end
