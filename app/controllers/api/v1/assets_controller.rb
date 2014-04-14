class Api::V1::AssetsController < Api::V1::ApplicationController
  def index
    render json: Asset.find(params[:ids])
  end

  def show
    render json: Asset.find(params[:id]), root: klass
  end

  def create
    @asset = Asset.new(asset_params)
    if @asset.save
      render json: @asset, root: klass
    else
      render json: {errors: @asset.errors.messages}, status: :unprocessable_entity
    end
  end

  def update
    @asset = asset.find(params[:id])
    if @asset.update_attributes(asset_params)
      render json: @asset, root: klass
    else
      render json: @asset.errors, root: klass, status: :unprocessable_entity
    end
  end

  def destroy
    @asset = asset.find(params[:id])
    if @asset.destroy
      render json: nil, status: :ok
    else
      render json: @asset.errors, root: klass, status: :unprocessable_entity
    end
  end

  private

  def asset_params
    params.require(:asset).permit(:name, :url, :website_id)
  end

  def klass
    "asset"
  end


end
