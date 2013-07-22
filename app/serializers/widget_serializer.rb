class WidgetSerializer < ActiveModel::Serializer
  attributes  :id,
              :web_template_id,
              :name,
              :thumbnail,
              :url,
              :section
end
