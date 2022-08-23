class Question < ApplicationRecord
  belongs_to :user
  
  belongs_to :author,
    class_name: 'User',
    optional:   true

  scope :latest, -> { order(created_at: :desc) }

  validates :body,
    presence: true,
    length:   { maximum: 280 }

  validates :user_id,
    presence: true
end
