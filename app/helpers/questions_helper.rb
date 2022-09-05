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

  def text_with_links_to_hashtags(text)
    sanitize(
      text.gsub(Hashtag::REGEX) do |hashtag|
        link_to(hashtag, hashtag_path(hashtag.delete_prefix('#').downcase))
      end
    )
  end

  def text_with_linebreaks(text)
    simple_format(h(text))
  end
end
