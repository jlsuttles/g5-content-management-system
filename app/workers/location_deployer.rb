class LocationDeployer
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :deployer

  def self.perform(location_id)
    @location = Location.find(location_id)
    @location.create_root_directory

    @location.pages.each do |page|
      @page = page
      controller = LocationsController.new
      File.open(@page.compiled_file_path, 'w') do |file|
        file << controller.render_to_string("/pages/preview", layout: false, :locals => {:page => page, location: @location})
      end
    end
    begin
      @location.deploy
    ensure
      @location.clean_up
    end
  end
end
