class SettingsController < ApplicationController
  def index
    @settings = Setting.order("name ASC").order("priority ASC").decorate
  end
end
