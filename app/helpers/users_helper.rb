module UsersHelper
  def nickname_for_display(nickname)
    "@#{nickname}"
  end

  def default_header_color
    '#370617'
  end

  def header_color(user)
    user&.header_color || default_header_color
  end

  def header_color_css(user)
    "style=background-color:#{header_color(user)}"
  end
end
