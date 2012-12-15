class ColorsSassFile
  def initialize(colors)
    @primary_color = colors[:primary]
    @secondary_color = colors[:secondary]
  end

  # renders app/views/pages/colors.scss.erb as a string
  # uses locals to evaluate erb
  def colors
    PagesController.new.render_to_string "colors",
      formats: [:scss],
      layout:  false,
      locals:  { 
        primary_color: @primary_color,
        secondary_color: @secondary_color
      }
  end
end
