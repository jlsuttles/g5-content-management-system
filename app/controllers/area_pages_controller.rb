class AreaPagesController < ApplicationController
  def show
    @locations = LocationCollector.new(params).collect

    render "area_pages/show"
  end
end
