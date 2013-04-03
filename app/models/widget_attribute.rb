class WidgetAttribute < ActiveRecord::Base
  attr_accessible :default_value, :editable, :name, :value
  liquid_methods :name, :default_value, :id, :value

  belongs_to :property_group

  before_create :assign_lead_widget_submission_url, if: :lead_widget_submission_url?

  def lead_widget_submission_url?
    lead_widget? && submission_url?
  end

  def lead_widget?
    property_group.component.kind_of_widget?("Lead Form")
  end

  def submission_url?
    name == "submission_url"
  end

  def assign_lead_widget_submission_url
    self.value = ENV["LEADS_SERVICE_HEROKU_URL"]
  end
end
