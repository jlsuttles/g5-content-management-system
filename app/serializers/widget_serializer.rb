class WidgetSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :thumbnail,
              :url,
              :web_template_id
end
