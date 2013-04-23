require_dependency "hash_with_to_liquid"

class Setting < ActiveRecord::Base
  PRIORITIZED_OWNERS = [
    "Widget",
    "WebTemplate",
    "WebPageTemplate",
    "WebsiteTemplate",
    "WebLayout",
    "WebTheme",
    "Website",
    "Location",
    "Client"
  ]

  attr_accessible :owner_id,
                  :owner_type,
                  :name,
                  :editable,
                  :value,
                  :default_value,
                  :categories,
                  :priority

  serialize :value
  serialize :categories, Array

  belongs_to :owner, polymorphic: true

  before_create :set_priority
  before_update :update_self, if: :collection?
  after_update :update_others, if: :collection?

  validates :name, presence: true
  validates :owner, presence: true
  validates :owner_type, presence: true, inclusion: { in: PRIORITIZED_OWNERS }
  validates :priority, presence: true, numericality: { only_integer: true },
    unless: :new_record?

  scope :where_name, lambda { |name| where(name: name) }
  scope :value_is_present, where("value IS NOT NULL")
  scope :order_priority_asc, order("priority ASC")
  scope :order_priority_desc, order("priority DESC")
  scope :where_priority_gte, lambda { |priority| where("priority >= ?", priority) }
  scope :where_priority_gt, lambda { |priority| where("priority > ?", priority) }
  scope :where_priority_lt, lambda { |priority| where("priority < ?", priority) }

  def collection?
    categories.include?("collection")
  end

  # TODO: rename to best_value to value
  # TODO: rename value to my_value or something
  def best_value
    value || others_with_lower_priority.first.try(:value)
  end

  def others_with_higher_priority
    self.class.where_name(name).value_is_present.order_priority_desc.
      where_priority_lt(priority)
  end

  def others_with_lower_priority
    self.class.where_name(name).value_is_present.order_priority_asc.
      where_priority_gt(priority)
  end

  def next_with_higher_priority
    others_with_higher_priority.first
  end

  def next_with_lower_priority
    others_with_lower_priority.first
  end

  def merge_value_with_lower_priority(other)
    if other_value = other.try(:value)
      new_value = []
      other_value.each_with_index do |other_partial_value, index|
        if my_partial_value = value.is_a?(Array) ? value[index] : value[index.to_s]
          partial_value = other_partial_value.merge(my_partial_value)
          new_value << HashWithToLiquid[partial_value] if partial_value
        else
          new_value << HashWithToLiquid[other_partial_value]
        end
      end
      self.value = new_value
    end
    self
  end

  def merge_value_with_lower_priority!(other)
    merge_value_with_lower_priority(other).save
  end

  def merge_next_value_with_lower_priority
    merge_value_with_lower_priority(next_with_lower_priority)
  end

  def merge_next_value_with_lower_priority!
    merge_next_value_with_lower_priority.save
  end

  private

  def set_priority
    self.priority ||= PRIORITIZED_OWNERS.index(owner_type)
  end

  def update_self
    merge_next_value_with_lower_priority
  end

  def update_others
    next_with_higher_priority.try :merge_next_value_with_lower_priority!
  end
end
