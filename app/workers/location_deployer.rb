class LocationDeployer
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :deployer

  def self.perform(location_id)
    @location = Location.find(location_id)
    @location.pages.each do |page|
      @page = page
      ac = ActionController::Base.new()
      File.open(@page.compiled_file_path, 'w') { |file| file << ac.render_to_string("/pages/preview", layout: false) }
    end
    @location.deploy
  end
end
