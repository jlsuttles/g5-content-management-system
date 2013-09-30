App.WebsiteRoute = Ember.Route.extend
  setupController: (controller, model)->
    controller.set("model", model)
    # setup other controllers
    @controllerFor("location").set("model", model.get("location"))
    @controllerFor("websiteTemplate").set("model", model.get("websiteTemplate"))
    @controllerFor("webHomeTemplate").set("model", model.get("webHomeTemplate"))
    @controllerFor("webHomeTemplate").set("model", model.get("webHomeTemplate"))
