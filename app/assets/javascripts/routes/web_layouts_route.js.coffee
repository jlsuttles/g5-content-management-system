G5ClientHub.WebLayoutsRoute = Ember.Route.extend
  model: ->
    return G5ClientHub.WebLayout.find()
  #
  # setupController: (controller) ->
  #   controller.set "model", G5ClientHub.WebLayout.find()
  #
  # setupController: ->
  #   @controllerFor("webLayout").set "model", G5ClientHub.WebLayout.find()
