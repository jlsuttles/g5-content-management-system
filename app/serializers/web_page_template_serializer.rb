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
    File.join(root_url, object.url)
  end
end
