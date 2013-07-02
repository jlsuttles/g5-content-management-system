G5ClientHub.WebsiteTemplateRoute = Ember.Route.extend
  setupController: (controller, model)->
    @controllerFor('webLayouts').set('model', G5ClientHub.WebLayout.find())
    @controllerFor('webThemes').set('model', G5ClientHub.WebTheme.find())