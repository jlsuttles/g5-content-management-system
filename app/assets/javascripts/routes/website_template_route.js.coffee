G5ClientHub.WebsiteTemplateRoute = Ember.Route.extend

  setupController: (params) ->
    @controller.set('setWebLayouts',  G5ClientHub.WebLayout.find())
