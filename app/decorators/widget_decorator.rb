class WidgetDecorator < Draper::Decorator

  delegate_all
  delegate :to_liquid

  decorates_association :settings

  def locations
    drop_target.web_template.client.locations.count
  end
end
