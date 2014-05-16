class WidgetDecorator < Draper::Decorator

  delegate_all
  decorates_association :settings

end

