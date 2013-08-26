require_dependency "hash_with_to_liquid"

class Setting < ActiveRecord::Base
  PRIORITIZED_OWNERS = [
    "Widget",
    "WebTemplate",
    "WebPageTemplate",
    "WebHomeTemplate",
    "WebsiteTemplate",
    "WebLayout",
    "WebTheme",
    "Website",
    "Location",
    "Client"
  ]

  serialize :value
  serialize :categories, Array

  belongs_to :owner, polymorphic: true
  belongs_to :website

  before_create :set_priority
  after_create :set_website_id
  # TODO: does this fire twice?
  before_update :update_self, if: :collection?
  after_update  :update_next, if: :collection?

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
  scope :for_website, lambda { |wid| where(website_id: wid) }
  scope :for_no_website, where("website_id IS NULL")

  def collection?
    categories.include?("collection")
  end

  # TODO: rename to best_value to value
  # TODO: rename value to my_value or something
  def best_value
    value || others_with_lower_priority.first.try(:value) || global_others.first.try(:value) || default_value
  end

  def global_others
    query = self.class
    query = query.for_no_website
    query = query.where_name(name)
    query = query.value_is_present
    query = query.order_priority_asc
  end

  def others_with_higher_priority
    query = self.class
    query = query.for_website(website_id) if website_id
    query = query.where_name(name)
    query = query.value_is_present
    query = query.order_priority_desc
    query = query.where_priority_lt(priority)
  end

  def others_with_lower_priority
    query = self.class
    query = query.for_website(website_id) if website_id
    query = query.where_name(name)
    query = query.value_is_present
    query = query.order_priority_asc
    query = query.where_priority_gt(priority)
  end

  def next_with_higher_priority
    others_with_higher_priority.first
  end

  def next_with_lower_priority
    others_with_lower_priority.first
  end

  def merge_value_with_lower_priority(other)
    if other_value = other.try(:value)
      if value
        new_value = []
        other_value.each_with_index do |other_partial_value, index|
          if my_partial_value = value.is_a?(Array) ? value[index] : value[index.to_s]
            other_partial_value["display"] = my_partial_value["display"]
          end
          new_value << HashWithToLiquid[other_partial_value]
        end
        self.value = new_value
      else
        self.value = other_value
      end
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

  def set_website_id
    self.website_id ||= owner.website_id if owner.respond_to?(:website_id)
    save
  end

  def set_priority
    self.priority ||= PRIORITIZED_OWNERS.index(owner_type)
  end

  def update_self
    merge_next_value_with_lower_priority
  end

  def update_next
    next_with_higher_priority.try :merge_next_value_with_lower_priority!
  end
end
