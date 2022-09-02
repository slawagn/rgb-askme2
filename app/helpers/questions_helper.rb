module QuestionsHelper
  def author_nickname(question)
    nickname_for_display(question.author&.nickname)
  end

  def author_display(question)
    if question.author.nil?
      'Аноним'
    else
      link_to author_nickname(question), user_path(question.author.nickname)
    end
  end

  def hashtag_display(tag)
    link_to "##{tag}", hashtag_path(tag)
  end
end
