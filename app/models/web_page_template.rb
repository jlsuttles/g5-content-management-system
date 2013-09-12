class WebPageTemplate < WebTemplate
  def all_widgets
    widgets + website.try(:website_template).try(:widgets).to_a
  end

  def head_widgets
    website.try(:website_template).try(:head_widgets).to_a
  end
end
