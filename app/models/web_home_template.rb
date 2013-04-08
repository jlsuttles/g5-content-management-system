class WebHomeTemplate < WebPageTemplate
  before_validation :assign_defaults

  private

  def assign_defaults
    self.name ||= "Homepage"
    self.title ||= name
  end
end
