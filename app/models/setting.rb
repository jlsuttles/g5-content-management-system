class Setting < ActiveRecord::Base
  belongs_to :component, polymorphic: true
  attr_accessible :categories, :component_id, :component_type, :name
  serialize :categories, Array
  validates :component, :name, presence: true
end
