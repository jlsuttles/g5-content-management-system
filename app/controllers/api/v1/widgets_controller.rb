class Api::V1::WidgetsController < Api::V1::ApplicationController
  def index
    render json: Widget.find(params[:ids])
  end

  def show
    render json: Widget.find(params[:id])
  end

  def create
    @widget = Widget.new(widget_params)
    if @widget.save
      render json: @widget
    else
      render json: @widget.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @widget = Widget.find(params[:id])
    if @widget.destroy
      render json: @widget
    else
      render json: @widget.errors, status: :unprocessable_entity
    end
  end

  private

  def widget_params
    params.require(:widget).permit(:url, :web_template_id)
  end
end
