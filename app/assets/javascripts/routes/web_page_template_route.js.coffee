App.WebPageTemplateRoute = Ember.Route.extend
  setupController: (controller, model)->
    # setup this controller
    controller.set("model", model)
    # setup widget controller
    @controllerFor("mainWidgets").set("model", model.get("mainWidgets"))
