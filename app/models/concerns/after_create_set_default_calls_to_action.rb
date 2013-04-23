module AfterCreateSetDefaultCallsToAction
  extend ActiveSupport::Concern

  AVAILABLE_CALLS_TO_ACTION = {
    "Apply" => "/lead_url/apply",
    "Brochure" => "/lead_url/brochure",
    "1234567890" => "tel:1234567890",
    "Contact"  => "/lead_url/contact",
    "Special Offer"  => "/coupon",
    "Hold Unit" => "/lead_url/hold",
    "Request Info" => "/lead_url/request_info",
    "Tour" => "/lead_url/tour"
  }.freeze

  DEFAULT_CALLS_TO_ACTION = [
    "1234567890", "Request Info", "Apply", "Special Offer"
  ].freeze

  included do
    after_create :set_default_calls_to_action, if: :calls_to_action_widget?
  end

  def set_default_calls_to_action
    numbers = %w{one two three four}
    get_default_calls_to_action.each_with_index do |cta, index|
      number = numbers[index]
      if text = self.settings.where(:name => "cta_#{number}_text").first
        text.update_attribute(:value, cta[0])
      end
      if url = self.settings.where(:name => "cta_#{number}_url").first
        url.update_attribute(:value, cta[1])
      end
    end
    true
  end

  def get_available_calls_to_action
    AVAILABLE_CALLS_TO_ACTION
  end

  def default_calls_to_action
    DEFAULT_CALLS_TO_ACTION
  end

  def get_default_calls_to_action
    @default_calls_to_action ||=
      AVAILABLE_CALLS_TO_ACTION.select{ |key| DEFAULT_CALLS_TO_ACTION.include?(key) }
  end

  def calls_to_action_widget?
    kind_of_widget?("Calls to Action")
  end

end
