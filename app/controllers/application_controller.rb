class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV["HTTP_BASIC_AUTH_NAME"], password: ENV["HTTP_BASIC_AUTH_PASSWORD"] if ENV["HTTP_BASIC_AUTH_NAME"] && ENV["HTTP_BASIC_AUTH_PASSWORD"]

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
