class ReleasesController < ApplicationController
  def rollback
    #ReleasesManager.new(params["website_slug"]).rollback(params[:id])
    redirect_to root_path, notice: "Rolling Back #{params["location_slug"]} To #{params[:rollback_id]}. This may take a few minutes."
  end
end
