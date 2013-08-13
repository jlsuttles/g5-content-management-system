App.WebsiteRoute = Ember.Route.extend
  setupController: (controller, model)->
    controller.set("model", model)
    # setup webPageTemplate controller
    @controllerFor("webPageTemplates").set("model", model.get("webPageTemplates"))