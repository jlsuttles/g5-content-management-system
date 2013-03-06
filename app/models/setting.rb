class Setting < ActiveRecord::Base
  include AssociationToMethod

  attr_accessible :categories, :component_id, :component_type, :name

  serialize :categories, Array

  belongs_to :component, polymorphic: true
  has_many :widget_attributes

  alias_method :dynamic_association, :widget_attributes

  validates :component, :name, presence: true
end
