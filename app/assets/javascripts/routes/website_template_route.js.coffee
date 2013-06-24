G5ClientHub.WebsiteTemplateRoute = Ember.Route.extend
  setupController: ->
    @controller.set 'webLayouts', G5ClientHub.WebLayout.find()
    @controller.set 'webThemes', G5ClientHub.WebTheme.find()
