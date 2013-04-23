class LocationDecorator < Draper::Decorator
  delegate_all
  decorates_association :website
end
