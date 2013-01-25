class WidgetsController < ApplicationController
  respond_to :html, :json
  def edit
    @widget = Widget.find(params[:id])
  end
  
  def update
    @widget = Widget.find(params[:id])
    if @widget.update_configuration(params[:widget])
      respond_with(@widget) do |format|
        format.html { redirect_to location_path(@widget.page.location) }
      end
    else
      respond_with do |format|
        format.json { render json: @widget.errors, status: :unprocessable_entity}
        format.html { render :edit }
      end
    end
  end
end
