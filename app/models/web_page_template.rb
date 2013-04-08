class WebPageTemplate < WebTemplate
  def sections
    %w(main)
  end

  def all_widgets
    widgets + website.try(:website_template).try(:widgets).to_a
  end

  def url
    name
  end

  def alt
    name
  end

  def display
    true
  end
end
