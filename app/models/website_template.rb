class WebsiteTemplate < WebTemplate
  # TODO: remove when Ember App implements DropTarget
  def head_widgets
    drop_targets.where(html_id: "drop-target-head").first.try(:widgets)
  end

  # TODO: remove when Ember App implements DropTarget
  def logo_widgets
    drop_targets.where(html_id: "drop-target-logo").first.try(:widgets)
  end

  # TODO: remove when Ember App implements DropTarget
  def btn_widgets
    drop_targets.where(html_id: "drop-target-btn").first.try(:widgets)
  end

  # TODO: remove when Ember App implements DropTarget
  def phone_widgets
    drop_targets.where(html_id: "drop-target-phone").first.try(:widgets)
  end

  # TODO: remove when Ember App implements DropTarget
  def nav_widgets
    drop_targets.where(html_id: "drop-target-nav").first.try(:widgets)
  end

  # TODO: remove when Ember App implements DropTarget
  def footer_widgets
    drop_targets.where(html_id: "drop-target-footer").first.try(:widgets)
  end

  # TODO: remove when Ember App implements DropTarget
  def aside_widgets
    drop_targets.where(html_id: "drop-target-aside").first.try(:widgets)
  end

  def stylesheets
    layout_stylesheets + widget_stylesheets
  end

  def layout_stylesheets
    compiled_pages_stylesheets +
      web_layout_stylesheets +
      web_theme_stylesheets
  end

  def compiled_pages_stylesheets
    [File.join(Rails.root, "app", "views", "compiled_pages", "stylesheets.scss")]
  end

  def web_layout_stylesheets
    web_layout ? web_layout.stylesheets : []
  end

  def web_theme_stylesheets
    web_theme ? web_theme.stylesheets : []
  end

  def widget_stylesheets
    widgets ? widgets.map(&:stylesheets).flatten : []
  end

  def javascripts
    widget_lib_javascripts + web_theme_javascripts + widget_show_javascripts
  end

  def widget_show_javascripts
    widgets ? widgets.map(&:show_javascript).flatten : []
  end

  def widget_lib_javascripts
    widgets ? widgets.map(&:lib_javascripts).flatten : []
  end

  def web_theme_javascripts
    web_theme ? web_theme.javascripts : []
  end

  def primary_color
    if website.custom_colors?
      website.primary_color
    else
      web_theme.try(:primary_color)
    end
  end

  def secondary_color
    if website.custom_colors?
      website.secondary_color
    else
      web_theme.try(:secondary_color)
    end
  end
end
