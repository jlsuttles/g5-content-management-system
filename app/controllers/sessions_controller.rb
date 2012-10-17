class SessionsController < ApplicationController
  def new
  end

  def create
    client = Client.authenticate(params[:login], params[:password])
    if client
      session[:client_id] = client.id
      redirect_to_target_or_default root_url, :notice => "Logged in successfully."
    else
      flash.now[:alert] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:client_id] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end
end
