class CallToAction

  CALLS_TO_ACTION = {
    "Apply" => "/lead_url/apply",
    "Brochure" => "/lead_url/brochure",
    "Call"     => "tel:1234567890",
    "Contact"  => "/lead_url/contact",
    "Special Offer"  => "/coupon",
    "Hold Unit" => "/lead_url/hold",
    "Request Info" => "/lead_url/request_info",
    "Tour" => "/lead_url/tour"
  }.freeze

  DEFAULT_CALLS_TO_ACTION = [
    "Call", "Request Info", "Apply", "Special Offer"
  ].freeze

  def self.default_calls_to_action
    CALLS_TO_ACTION.select{ |key| DEFAULT_CALLS_TO_ACTION.include?(key) }
  end

  def self.set_widget_defaults(widget)
    return unless widget.kind_of_widget?("Calls to Action")
    numbers = %w{One Two Three Four}
    default_calls_to_action.each_with_index do |cta, index|
      number = numbers[index]
      if text = widget.widget_attributes.where(:name => "CTA #{number} Text").first
        text.update_attribute(:value, cta[0])
      end
      if url = widget.widget_attributes.where(:name => "CTA #{number} URL").first
        url.update_attribute(:value, cta[1])
      end
    end
  end

end