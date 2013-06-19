G5ClientHub.WebsiteTemplateRoute = Ember.Route.extend
  # model: (params) ->
    # G5ClientHub.WebLayout.find(params.id)

  setupController: (params) ->
    @controller.set('setWebLayouts',  G5ClientHub.WebLayout.find())
