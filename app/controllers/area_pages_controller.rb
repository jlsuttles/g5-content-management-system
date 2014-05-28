class AreaPagesController < ApplicationController
  def show
    @locations = LocationCollector.new(params).collect

    render "area_pages/show", layout: "area_page", locals: { locations: @locations, }
  end
end

