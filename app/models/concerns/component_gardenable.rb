module ComponentGardenable
  extend ActiveSupport::Concern

  module ClassMethods
    def set_garden_url(garden_url)
      @garden_url = garden_url
    end

    def garden_url
      @garden_url
    end

    def component_url(component_name)
      "#{garden_url}/components/#{component_name}"
    end

    def if_modified_since
      cached_http_headers["last-modified"]
    end

    def cached_http_headers
      @http_headers ||= {}
    end

    def garden_microformats
      parser = Microformats2::Parser.new
      @microformats = parser.parse(garden_url,
        {"If-Modified-Since" => if_modified_since.to_s}) || @microformats
      @http_headers = parser.http_headers
      @microformats
    rescue OpenURI::HTTPError => e
      if e.message.include?("304")
        @microformats || []
      else
        raise e
      end
    end

    def components_microformats
      if garden_microformats.respond_to?(:g5_components)
        garden_microformats.g5_components
      else
        []
      end
    end
  end

  def component_microformat
    component = Microformats2.parse(url).first
    raise "No h-g5-component found at url: #{url}" unless component
    component
  rescue OpenURI::HTTPError => e
    Rails.logger.warn e.message
  end
end
