class WidgetEntriesController < ApplicationController
  def index
    @widget_entries = WidgetEntry.order("updated_at DESC").decorate
  end

  def show
    @widget_entry = WidgetEntry.find(params[:id]).decorate
  end
end
