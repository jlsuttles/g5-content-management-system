class WidgetsController < ApplicationController
  respond_to :html, :json, :js
  def edit
    @widget = Widget.find(params[:id])
    html = render_to_string(format: :html, layout: false)
    respond_with do |format|
      format.json { render json: {html: html} } 
    end
  end
  
  def update
    @widget = Widget.find(params[:id])
    if @widget.update_configuration(params[:widget])
      respond_with(@widget) do |format|
        format.json { render json: @widget, status: 204}
        format.html { redirect_to location_path(@widget.page.location) }
      end
    else
      respond_with do |format|
        format.json { render json: {errors: @widget.errors}, status: :unprocessable_entity}
        format.html { render :edit }
      end
    end
  end
end
