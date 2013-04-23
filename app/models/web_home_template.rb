class WebHomeTemplate < WebPageTemplate
  after_initialize :assign_defaults

  private

  def assign_defaults
    self.name  ||= "Homepage"
    self.title ||= name
    self.slug  ||= title.parameterize
  end
end
