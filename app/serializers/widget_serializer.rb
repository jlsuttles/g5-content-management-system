class WidgetSerializer < ActiveModel::Serializer

  attributes  :id,
              :drop_target_id,
              :name,
              :thumbnail,
              :url,
              :section,
              :display_order,
              :display_order_position
end
