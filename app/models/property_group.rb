class PropertyGroup < ActiveRecord::Base
  include AssociationToMethod

  attr_accessible :categories, :component_id, :component_type, :name

  serialize :categories, Array

  belongs_to :component, polymorphic: true
  has_many :properties

  alias_method :dynamic_association, :properties

  validates :component, :name, presence: true
end
