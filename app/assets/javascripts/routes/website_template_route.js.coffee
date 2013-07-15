G5ClientHub.WebsiteTemplateRoute = Ember.Route.extend
  setupController: (controller, model)->
    # setup website template
    controller.set("model", model);
    # setup website template associations
    @controllerFor("webLayout").set("model", model.get("webLayout"))
    @controllerFor("webTheme").set("model", model.get("webTheme"))
    @controllerFor("widgets").set("model", model.get("widgets"))
    # setup remote components
    @controllerFor("remoteWebLayouts").set("model", G5ClientHub.RemoteWebLayout.find())
    @controllerFor("remoteWebThemes").set("model", G5ClientHub.RemoteWebTheme.find())
    @controllerFor("remoteWidgets").set("model", G5ClientHub.RemoteWidget.find())
