module UsersHelper
  def nickname_for_display(nickname)
    "@#{nickname}"
  end

  def css_header_color_for_user(user)
    if user.nil?
      "navbar-red"
    else
      "navbar-#{user.header_color}"
    end
  end

  def color_human_readable(color)
    case color
    when 'red'
      'красный'
    when 'orange'
      'оранжевый'
    when 'blue'
      'синий'
    when 'pink'
      'розовый'
    end
  end

  def header_color_selection_hash
    User.header_colors.keys.to_h do |color|
      [color_human_readable(color).capitalize, color]
    end
  end
end
