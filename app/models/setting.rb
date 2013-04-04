class Setting < ActiveRecord::Base
  attr_accessible :owner_id,
                  :owner_type,
                  :editable,
                  :name,
                  :value,
                  :default_value,
                  :categories

  liquid_methods :name, :default_value, :id, :value

  belongs_to :owner, polymorphic: true

  serialize :categories

  before_create :assign_lead_widget_submission_url, if: :lead_widget_submission_url?

  validates :name, presence: true
  validates :owner, presence: true

  def lead_widget_submission_url?
    lead_widget? && submission_url?
  end

  def lead_widget?
    owner.respond_to?(:kind_of_widget) && owner.kind_of_widget?("Lead Form")
  end

  def submission_url?
    name == "submission_url"
  end

  def assign_lead_widget_submission_url
    self.value = ENV["LEADS_SERVICE_HEROKU_URL"]
  end
end
