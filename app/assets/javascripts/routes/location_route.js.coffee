G5ClientHub.LocationRoute = Ember.Route.extend
  setupController: (controller, model)->
    # setup this controller
    controller.set("model", model)
    # setup website controller
    @controllerFor("website").set("model", model.get("website"))
    # setup website.websiteTemplate controllers
    @controllerFor("websiteTemplate").set("model", model.get("websiteTemplate"))
    @controllerFor("webLayout").set("model", model.get("website.websiteTemplate.webLayout"))
    @controllerFor("webTheme").set("model", model.get("website.websiteTemplate.webTheme"))
    @controllerFor("logoWidgets").set("model", model.get("website.websiteTemplate.logoWidgets"))
    @controllerFor("phoneWidgets").set("model", model.get("website.websiteTemplate.phoneWidgets"))
    @controllerFor("btnWidgets").set("model", model.get("website.websiteTemplate.btnWidgets"))
    @controllerFor("navWidgets").set("model", model.get("website.websiteTemplate.navWidgets"))
    @controllerFor("asideWidgets").set("model", model.get("website.websiteTemplate.asideWidgets"))
    @controllerFor("footerWidgets").set("model", model.get("website.websiteTemplate.footerWidgets"))
    # setup remote controllers last
    @controllerFor("remoteWebLayouts").set("model", G5ClientHub.RemoteWebLayout.find())
    @controllerFor("remoteWebThemes").set("model", G5ClientHub.RemoteWebTheme.find())
    @controllerFor("remoteWidgets").set("model", G5ClientHub.RemoteWidget.find())
