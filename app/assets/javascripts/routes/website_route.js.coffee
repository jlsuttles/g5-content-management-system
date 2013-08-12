App.WebsiteRoute = Ember.Route.extend
  setupController: (controller, model)->
    controller.set("model", model)
    # @controllerFor("location").set("model", model.get("locationId"))