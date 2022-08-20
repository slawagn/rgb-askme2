class Question < ApplicationRecord
  default_scope { order(created_at: :asc) }

  validates :body,
    presence: true,
    length:   { maximum: 280 }

  validates :user_id,
    presence: true
end
