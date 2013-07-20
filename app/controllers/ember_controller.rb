class EmberController < ApplicationController
  def start
    render layout: "ember-builder"
  end
end
