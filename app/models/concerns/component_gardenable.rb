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
      garden_microformats.g5_components
    end

    def all_remote
      components_microformats.map do |microformat|
        new do |component|
          component.url = microformat.uid.to_s
          component.name = microformat.name.to_s
          component.thumbnail = microformat.photo.to_s
        end
      end
    end
  end
end
