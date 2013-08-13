App.WebsiteRoute = Ember.Route.extend
  setupController: (controller, model)->
    controller.set("model", model)
    # setup other controllers
    @controllerFor("webHomeTemplate").set("model", model.get("webHomeTemplate"))
    @controllerFor("webPageTemplates").set("model", model.get("webPageTemplate"))
    @controllerFor("websiteTemplate").set("model", model.get("websiteTemplate"))