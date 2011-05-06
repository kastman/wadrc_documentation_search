module TextfilesHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
  
  @prefix = ''
  @suffix = ''

  def add(open, close = open)
    @prefix << "<#{open}>"
    @suffix = "</#{close}>#{@suffix}"
  end

  def format(str, section)
    @prefix = ''
    @suffix = ''

    mods = section[:modifiers]

    if mods[:paragraph]
      if section[:text].empty?
        str << "<p></p>\n"
      else
        add('p')
      end

    elsif mods[:tab]
      str << "&nbsp;&nbsp;&nbsp;&nbsp;"
      return
    elsif mods[:newline]
      str << "<br />\n"
      return
    elsif mods[:rquote]
      str << "&rsquo;"
      return
    elsif mods[:lquote]
      str << "&lsquo;"
      return
    elsif mods[:ldblquote]
      str << "&ldquo;"
      return
    elsif mods[:rdblquote]
      str << "&rdquo;"
      return
    elsif mods[:emdash]
      str << "&mdash;"
      return
    elsif mods[:endash]
      str << "&ndash;"
      return
    elsif mods[:nbsp]
      str << "&nbsp;"
      return
    end
    return if section[:text].empty?

    add('b') if mods[:bold]
    add('i') if mods[:italic]
    add('u') if mods[:underline]
    add('sup') if mods[:superscript]
    add('sub') if mods[:subscript]
    add('del') if mods[:strikethrough]

    style = ''
    style << "font-variant: small-caps;" if mods[:smallcaps]
    style << "font-size: #{mods[:font_size]}pt;" if mods[:font_size]
    style << "font-family: \"#{mods[:font].name}\";" if mods[:font]
    if mods[:foreground_colour] && !mods[:foreground_colour].use_default?
      colour = mods[:foreground_colour]
      style << "color: rgb(#{colour.red},#{colour.green},#{colour.blue});"
    end
    if mods[:background_colour] && !mods[:background_colour].use_default?
      colour = mods[:background_colour]
      style << "background-color: rgb(#{colour.red},#{colour.green},#{colour.blue});"
    end

    add("span style='#{style}'", 'span') unless style.empty?

    str << @prefix + section[:text].force_encoding('UTF-8') + @suffix
  end
  
end
