class WebHomeTemplateSerializer < WebTemplateSerializer
  embed :ids, include: true

  has_many :main_widgets

  attributes :preview_url

  def preview_url
    website_web_home_template_url(object.website, object)
  end
end
