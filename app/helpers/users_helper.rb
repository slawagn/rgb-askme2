module UsersHelper
  def nickname_for_display(nickname)
    "@#{nickname}"
  end

  def header_color_style(user)
    color = user&.header_color || User::DEFAULT_HEADER_COLOR
    
    "style=background-color:#{color}"
  end
end
