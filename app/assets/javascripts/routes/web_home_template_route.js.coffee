App.WebHomeTemplateRoute = Ember.Route.extend
  setupController: (controller, model)->
    # setup this controller
    controller.set("model", model)
    # setup website controller
    @controllerFor("website").set("model", model.get("website"))
    # setup webThemeColors controller
    @controllerFor("webThemeColors").set("model", model.get("website"))
    # setup widgets controller
    @controllerFor("mainWidgets").set("model", model.get("mainWidgets"))
    @controllerFor("headWidgets").set("model", model.get("website.websiteTemplate.headWidgets"))
    @controllerFor("logoWidgets").set("model", model.get("website.websiteTemplate.logoWidgets"))
    @controllerFor("phoneWidgets").set("model", model.get("website.websiteTemplate.phoneWidgets"))
    @controllerFor("btnWidgets").set("model", model.get("website.websiteTemplate.btnWidgets"))
    @controllerFor("navWidgets").set("model", model.get("website.websiteTemplate.navWidgets"))
    @controllerFor("asideWidgets").set("model", model.get("website.websiteTemplate.asideWidgets"))
    @controllerFor("footerWidgets").set("model", model.get("website.websiteTemplate.footerWidgets"))

  serialize: (model) ->
    web_home_template_slug: model.get("slug")
