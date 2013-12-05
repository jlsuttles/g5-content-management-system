class WebHomeTemplateSerializer < WebTemplateSerializer
  embed :ids, include: true

  has_many :main_widgets

  attributes :heroku_url,
             :preview_url,
             :name,
             :title,
             :disabled,
             :slug

  def heroku_url
    object.website.decorate.heroku_url
  end

  def preview_url
    web_template_url(object)
  end

  def slug
    object.name.parameterize
  end
end
