class WidgetSupport
  class << self
    def all_remote
      VCR.use_cassette("Widget/all_remote") do
        @all_remote ||= Widget.all_remote
      end
    end

    # Use for general cases
    def widget
      @widget ||= all_remote.first
    end

    def twitter_feed
      @twitter_feed ||= all_remote.find do |widget|
        widget.name.downcase == "twitter feed"
      end
    end
  end
end
