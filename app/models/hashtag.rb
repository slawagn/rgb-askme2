class Hashtag < ApplicationRecord
  REGEX = /#[[:word:]+-]+/i

  has_many :hashtag_questions

  has_many :questions,
    through: :hashtag_questions

  validates :tag,
    uniqueness: true

  scope :not_empty, -> { Hashtag.joins(:questions).group('hashtags.id').having('COUNT(questions.id) > 0') }
    
  scope :top, -> {
    left_joins(:hashtag_questions)
      .group(:id)
      .order(
        Arel.sql('COUNT(hashtags.id) DESC')
      )
  }
end
