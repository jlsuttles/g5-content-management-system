class WebPageTemplateSerializer < WebTemplateSerializer
  embed :ids, include: true

  has_many :main_widgets

  attributes :preview_url,
             :name,
             :title,
             :enabled,
             :slug,
             :display_order,
             :redirect_patterns,
             :in_trash

  def preview_url
    web_template_url(object)
  end

  def slug
    object.name.parameterize
  end
end
