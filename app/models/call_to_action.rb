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

  def self.options_for_select
    CALLS_TO_ACTION.map{ |k,v| [v,v] }
  end

end