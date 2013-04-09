class SettingDecorator < Draper::Decorator

  delegate_all

  liquid_methods :field_name, :field_id, :hidden_field_for_id, :value

  def field_name
    "#{ owner_type.underscore }[settings_attributes][#{ id }]"
  end

  def field_id
    field_name.underscore
  end

  def hidden_field_for_id
    h.hidden_field_tag("#{field_name}[id]", id)
  end
end
