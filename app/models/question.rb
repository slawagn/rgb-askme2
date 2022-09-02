class Question < ApplicationRecord
  belongs_to :user
  
  belongs_to :author,
    class_name:  'User',
    foreign_key: 'author_id',
    optional:    true

  has_many :hashtag_questions,
    dependent: :destroy

  has_many :hashtags,
    through: :hashtag_questions

  scope :latest, -> { order(created_at: :desc) }

  validates :body,
    presence: true,
    length:   { maximum: 280 }

  validates :user_id,
    presence: true

  after_commit :create_hashtags

  private

  def create_hashtags
    hashtag_regex = /#[[:word:]+-]+/i

    ActiveRecord::Base.transaction do
      hashtag_questions.destroy_all

      body.scan(hashtag_regex).each do |tag_string|
        tag_string = tag_string.downcase.delete_prefix('#')
        
        hashtag = Hashtag.where(tag: tag_string).first_or_create

        hashtag_questions.create!(hashtag: hashtag, question: self)
      end
    end
  end
end
