class SettingsController < ApplicationController
  def index
    @settings = Setting.order("priority ASC").order("name ASC").decorate
  end
end
