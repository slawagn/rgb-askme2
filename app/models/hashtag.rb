class Hashtag < ApplicationRecord
  has_many :hashtag_questions

  has_many :questions,
    through: :hashtag_questions

  validates :tag,
    uniqueness: true
end
