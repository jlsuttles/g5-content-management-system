class WebHomeTemplate < WebPageTemplate
  after_initialize :assign_defaults
  
  DEFAULT_WIDGETS = [
    "calls-to-action",
    "social-links"
  ]  

  def type_for_route
    self.type
  end

  private

  def assign_defaults
    self.name  ||= "Home"
    self.title ||= name
    self.slug  ||= title.parameterize
  end
end
