class WebThemeSupport
  class << self
    def all_remote
      VCR.use_cassette("WebTheme/all_remote") do
        @all_remote ||= WebTheme.all_remote
      end
    end

    # Use for general cases
    def web_theme
      @web_theme ||= all_remote.first
    end
  end
end
