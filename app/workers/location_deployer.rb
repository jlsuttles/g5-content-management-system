class LocationDeployer
  @queue = :deployer

  def self.perform(location_id)
    location = Location.find(location_id)
    location.deploy
  end
end
