G5ClientHub.WebsiteTemplateRoute = Ember.Route.extend
  setupController: (controller, model)->
    @controllerFor("webLayout").set("model", model.get("webLayout"))
    @controllerFor("webTheme").set("model", model.get("webTheme"))
    @controllerFor("webLayouts").set("model", G5ClientHub.WebLayout.find())
    @controllerFor("webThemes").set("model", G5ClientHub.WebTheme.find())
    @controllerFor("widgets").set("model", G5ClientHub.Widget.find())
