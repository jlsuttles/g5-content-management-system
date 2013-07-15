module ComponentGardenable
  extend ActiveSupport::Concern

  module ClassMethods
    def set_garden_url(garden_url)
      @garden_url = garden_url
    end

    def garden_url
      @garden_url
    end

    def microformats_parser
      @microformats_parser ||= Microformats2::Parser.new
    end

    def if_modified_since
      microformats_parser.http_headers["last-modified"]
    end

    def garden_microformats
      @microformats = microformats_parser.parse(garden_url,
        {"If-Modified-Since" => if_modified_since.to_s})
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

    def all_remote
      components_microformats.map do |microformat|
        new do |component|
          assign_from_microformat(component, :url, microformat, :uid)
          assign_from_microformat(component, :name, microformat, :name)
          assign_from_microformat(component, :thumbnail, microformat, :photo)
        end
      end
    end

    def assign_from_microformat(component, component_attr, microformat, microformat_attr)
      component_method = "#{component_attr}="
      microformat_method = "#{microformat_attr}"
      if component.respond_to?(component_method) && microformat.respond_to?(microformat_method)
        component.send(component_method, microformat.send(microformat_method).to_s)
      end
    end
  end
end
