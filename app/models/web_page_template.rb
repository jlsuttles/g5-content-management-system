class WebPageTemplate < WebTemplate
  after_initialize :assign_defaults

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

  private

  def assign_defaults
    self.name  ||= "New Page"
    self.title ||= name
    self.slug  ||= title.parameterize
  end
end
