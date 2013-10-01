class WebLayoutSupport
  class << self
    def all_remote
      VCR.use_cassette("WebLayout/all_remote") do
        @all_remote ||= WebLayout.all_remote
      end
    end

    # Use for general cases
    def web_layout
      @web_layout ||= all_remote.first
    end

    def aside_first_sidebar_left
      @aside_first_sidebar_left ||= all_remote.find do |web_layout|
        web_layout.name.downcase == "aside first sidebar left"
      end
    end
  end
end
