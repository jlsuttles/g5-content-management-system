class WebPageTemplateSerializer < WebTemplateSerializer
  embed :ids, include: true

  has_many :main_widgets

  attributes :preview_url

  def preview_url
    website_web_page_template_url(object.website, object)
  end
end
