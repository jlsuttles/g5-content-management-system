class LocationDecorator < Draper::Decorator
  delegate_all
  decorates_association :website

  liquid_methods :name, :id
end
