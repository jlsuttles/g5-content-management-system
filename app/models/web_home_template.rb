class WebHomeTemplate < WebPageTemplate
  after_initialize :assign_defaults
  
  DEFAULT_WIDGETS = [
    "calls-to-action",
    "social-links"
  ]  

  private

  def assign_defaults
    self.name  ||= "Home"
    self.title ||= name
    self.slug  ||= title.parameterize
  end
end
