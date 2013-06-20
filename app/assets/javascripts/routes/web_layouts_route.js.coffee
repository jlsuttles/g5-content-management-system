G5ClientHub.WebLayoutsRoute = Ember.Route.extend
  model: ->
    return G5ClientHub.WebLayout.find()