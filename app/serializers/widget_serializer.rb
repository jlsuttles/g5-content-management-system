class WidgetSerializer < ActiveModel::Serializer

  attributes  :id,
              :website_template_id,
              :web_home_template_id,
              :web_page_template_id,
              :name,
              :thumbnail,
              :url,
              :section

  def website_template_id
    object.web_template_id
  end

  def web_home_template_id
    object.web_template_id
  end

  def web_page_template_id
    object.web_template_id
  end
end
