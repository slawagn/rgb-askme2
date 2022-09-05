class Hashtag < ApplicationRecord
  REGEX = /#[[:word:]+-]+/i

  has_many :hashtag_questions

  has_many :questions,
    through: :hashtag_questions

  validates :tag,
    uniqueness: true
  
  scope :top, -> {
    Hashtag
      .left_joins(:hashtag_questions)
      .group(:id)
      .order(
        Arel.sql('COUNT(hashtags.id) DESC')
      )
  }
end
