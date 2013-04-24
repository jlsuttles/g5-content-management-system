class WebPageTemplate < WebTemplate
  has_many :main_widgets,  class_name: "Widget",
    conditions: ['section = ?', 'main'], foreign_key: "web_template_id"

  after_initialize :assign_defaults
  after_create :create_default_widgets
  
  DEFAULT_WIDGETS = []

  def sections
    %w(main)
  end

  def all_widgets
    widgets + website.try(:website_template).try(:widgets).to_a
  end

  private

  def default_widgets
    self.class::DEFAULT_WIDGETS
  end

  def assign_defaults
    self.name  ||= "New Page"
    self.title ||= name
    self.slug  ||= title.parameterize
  end

  def create_default_widgets
    default_widgets.each do |widget|
      url = build_widget_url(widget)
      widgets.create(url: url, section: "main")
    end  
  end

  def build_widget_url(widget)
    ENV["WIDGET_GARDEN_URL"] + "/components/#{widget}"
  end
end
