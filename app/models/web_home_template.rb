class WebHomeTemplate < WebPageTemplate
  after_initialize :assign_defaults
  
  DEFAULT_WIDGETS = [
    "header-navigation",
    "calls-to-action",
    "social-links",
    "footer" 
  ]  

  private

  def assign_defaults
    self.name  ||= "Homepage"
    self.title ||= name
    self.slug  ||= title.parameterize
  end
end
