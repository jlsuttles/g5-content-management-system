class WebPageTemplate < WebTemplate
  def all_widgets
    widgets + website.try(:website_template).try(:widgets).to_a
  end

  def head_widgets
    website.try(:website_template).try(:head_widgets).to_a
  end

  def htaccess_substitution
    ["/", path, "/"].join
  end

  def path
    File.join(client.vertical_slug, location.state_slug, location.city_slug, slug)
  end
end
