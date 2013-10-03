App.WebsiteRoute = Ember.Route.extend
  setupController: (controller, model)->
    controller.set("model", model)
    # setup other controllers
    @controllerFor("location").set("model", model.get("location"))
    @controllerFor("websiteTemplate").set("model", model.get("websiteTemplate"))
    @controllerFor("webPageTemplate").set("model", model.get("webPageTemplate"))
    @controllerFor("webHomeTemplate").set("model", model.get("webHomeTemplate"))
