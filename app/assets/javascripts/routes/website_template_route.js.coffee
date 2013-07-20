G5ClientHub.WebsiteTemplateRoute = Ember.Route.extend
  setupController: (controller, model)->
    # setup website template
    controller.set("model", model);
    # setup website template associations
    @controllerFor("webLayout", model.get("webLayout"))
    @controllerFor("webTheme", model.get("webTheme"))
    @controllerFor("widgets", model.get("widgets"))
    @controllerFor("logoWidgets", model.get("logoWidgets"))
    @controllerFor("phoneWidgets", model.get("phoneWidgets"))
    @controllerFor("btnWidgets", model.get("btnWidgets"))
    @controllerFor("navWidgets", model.get("navWidgets"))
    @controllerFor("asideWidgets", model.get("asideWidgets"))
    @controllerFor("footerWidgets", model.get("footerWidgets"))
    # setup remote components
    @controllerFor("remoteWebLayouts", G5ClientHub.RemoteWebLayout.find())
    @controllerFor("remoteWebThemes", G5ClientHub.RemoteWebTheme.find())
    @controllerFor("remoteWidgets", G5ClientHub.RemoteWidget.find())
