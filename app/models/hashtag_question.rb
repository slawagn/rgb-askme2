class HashtagQuestion < ApplicationRecord
  belongs_to :hashtag
  belongs_to :question

  validates :hashtag_id,
    uniqueness: { scope: :question_id }

  after_destroy :destroy_hashtag_if_orphan

  private

  def destroy_hashtag_if_orphan
    hashtag.destroy if hashtag.hashtag_questions.empty?
  end
end
