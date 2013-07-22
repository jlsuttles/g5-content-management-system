G5ClientHub.WebsiteTemplateRoute = Ember.Route.extend
  setupController: (controller, model)->
    # setup website template
    controller.set("model", model);
    # setup website template associations
    @controllerFor("webLayout").set("model", model.get("webLayout"))
    @controllerFor("webTheme").set("model", model.get("webTheme"))
    @controllerFor("logoWidgets").set("model", model.get("logoWidgets"))
    @controllerFor("phoneWidgets").set("model", model.get("phoneWidgets"))
    @controllerFor("btnWidgets").set("model", model.get("btnWidgets"))
    @controllerFor("navWidgets").set("model", model.get("navWidgets"))
    @controllerFor("asideWidgets").set("model", model.get("asideWidgets"))
    @controllerFor("footerWidgets").set("model", model.get("footerWidgets"))
    # setup remote components
    @controllerFor("remoteWebLayouts").set("model", G5ClientHub.RemoteWebLayout.find())
    @controllerFor("remoteWebThemes").set("model", G5ClientHub.RemoteWebTheme.find())
    @controllerFor("remoteWidgets").set("model", G5ClientHub.RemoteWidget.find())
