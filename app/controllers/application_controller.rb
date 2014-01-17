class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :client_name
  helper_method :client

  def client
    @client ||= Client.first
  end

  def client_name
    @client_name ||= client.name if client
  end
end
