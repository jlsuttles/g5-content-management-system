class LocationDeployer
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :deployer

  def self.perform(location_id)
    @location = Location.find_by_urn(location_id)
    compile_pages(@location)
    begin
      @location.deploy
    ensure
      @location.clean_up
    end
  end
  def self.compile_pages(location)
    location.create_root_directory
    add_page_at_path(location.homepage, location, location.compiled_site_path + "index.html")
    location.pages.each do |page|
      add_page_at_path(page, location, page.compiled_file_path)
    end
  end

  def self.add_page_at_path(page, location, path)
    File.open(path, 'w') do |file|
      file << LocationsController.new.render_to_string("/pages/preview", layout: false, :locals => {:page => page, location: location})
    end
  end
end
