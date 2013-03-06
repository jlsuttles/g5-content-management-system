class Setting < ActiveRecord::Base
  include AssociationToMethod
  belongs_to :component, polymorphic: true
  has_many :widget_attributes
  alias_method :dynamic_association, :widget_attributes
  attr_accessible :categories, :component_id, :component_type, :name
  serialize :categories, Array
  validates :component, :name, presence: true
end
