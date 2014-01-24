class WebHomeTemplateSerializer < WebTemplateSerializer
  embed :ids, include: true

  has_many :main_widgets

  attributes :preview_url,
             :name,
             :title,
             :enabled,
             :slug,
             :redirect_patterns

  def preview_url
    File.join(root_url, object.preview_url)
  end

  def slug
    object.name.parameterize
  end
end
