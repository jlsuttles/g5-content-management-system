class ClientsController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      session[:client_id] = @client.id
      redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
    else
      render :action => 'new'
    end
  end

  def edit
    @client = current_client
  end

  def update
    @client = current_client
    if @client.update_attributes(params[:client])
      redirect_to root_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end
end
