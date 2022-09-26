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
    tags = scan_strings_for_hashtags(body, answer)

    self.hashtags = tags.map { |tag| Hashtag.find_or_create_by!(tag: tag) }
  end

  def scan_strings_for_hashtags(*strings)
    strings.join(' ')
      .scan(Hashtag::REGEX)
      .map do |tag_string|
        tag_string.downcase.delete_prefix('#')
      end
      .uniq
  end
end
