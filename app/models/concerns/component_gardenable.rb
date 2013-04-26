module ComponentGardenable
  extend ActiveSupport::Concern

  module ClassMethods
    def set_garden_url(garden_url)
      @garden_url = garden_url
    end

    def garden_url
      @garden_url
    end

    def garden_microformats
      Microformats2.parse(garden_url)
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
