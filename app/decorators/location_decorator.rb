class LocationDecorator < Draper::Decorator
  delegate_all
  decorates_association :website

  liquid_methods :name, :id, :website

  def id
    object.id.to_s
  end
end
