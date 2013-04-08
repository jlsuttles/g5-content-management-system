class SettingDecorator < Draper::Decorator

  delegate_all

  def field_name
    "#{ owner.type.underscore }[settings_attributes][#{ owner.id }]"
  end

  def field_id
    field_name.underscore
  end
end
