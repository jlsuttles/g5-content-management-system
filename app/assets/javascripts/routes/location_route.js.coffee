App.LocationRoute = Ember.Route.extend
  setupController: (controller, model)->
    # setup this controller
    controller.set("model", model)
    # setup website controller
    @controllerFor("website").set("model", model.get("website"))
    # setup webThemeColors controller
    @controllerFor("webThemeColors").set("model", model.get("website"))
    # setup website.websiteTemplate controllers
    @controllerFor("websiteTemplate").set("model", model.get("websiteTemplate"))
    @controllerFor("webLayout").set("model", model.get("website.websiteTemplate.webLayout"))
    @controllerFor("webTheme").set("model", model.get("website.websiteTemplate.webTheme"))
    @controllerFor("headWidgets").set("model", model.get("website.websiteTemplate.headWidgets"))
    @controllerFor("logoWidgets").set("model", model.get("website.websiteTemplate.logoWidgets"))
    @controllerFor("phoneWidgets").set("model", model.get("website.websiteTemplate.phoneWidgets"))
    @controllerFor("btnWidgets").set("model", model.get("website.websiteTemplate.btnWidgets"))
    @controllerFor("navWidgets").set("model", model.get("website.websiteTemplate.navWidgets"))
    @controllerFor("asideWidgets").set("model", model.get("website.websiteTemplate.asideWidgets"))
    @controllerFor("footerWidgets").set("model", model.get("website.websiteTemplate.footerWidgets"))
    # setup remote controllers last
    @controllerFor("remoteWebLayouts").set("model", App.RemoteWebLayout.find())
    @controllerFor("remoteWebThemes").set("model", App.RemoteWebTheme.find())
    @controllerFor("remoteWidgets").set("model", App.RemoteWidget.find())
