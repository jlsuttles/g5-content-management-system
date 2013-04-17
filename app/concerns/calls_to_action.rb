module CallsToAction
  extend ActiveSupport::Concern

  AVAILABLE_CALLS_TO_ACTION = {
    "Apply" => "/lead_url/apply",
    "Brochure" => "/lead_url/brochure",
    "1234567890"     => "tel:1234567890",
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
    after_create :set_default_calls_to_action, if: Proc.new{ |w| w.kind_of_widget?("Calls to Action") }
    liquid_methods :available_calls_to_action, :default_calls_to_action
  end

  def set_default_calls_to_action
    numbers = %w{One Two Three Four}
    get_default_calls_to_action.each_with_index do |cta, index|
      number = numbers[index]
      if text = self.widget_attributes.where(:name => "CTA #{number} Text").first
        text.update_attribute(:value, cta[0])
      end
      if url = self.widget_attributes.where(:name => "CTA #{number} URL").first
        url.update_attribute(:value, cta[1])
      end
    end
    true
  end

  def available_calls_to_action
    AVAILABLE_CALLS_TO_ACTION
  end

  def default_calls_to_action
    DEFAULT_CALLS_TO_ACTION
  end

  def get_default_calls_to_action
    @default_calls_to_action ||=
      AVAILABLE_CALLS_TO_ACTION.select{ |key| DEFAULT_CALLS_TO_ACTION.include?(key) }
  end

end