class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :client_name

  def client_name
    @client ||= Client.first
    @client_name ||= @client.name if @client
  end
end
