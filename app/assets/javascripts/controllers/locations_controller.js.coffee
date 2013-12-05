App.LocationsController = Ember.ArrayController.extend
  actions:
    deploy: (model) ->
      url = "/websites/" + model.get("website.id") + "/deploy"
      $("<form action='" + url + "' method='post'></form>").submit()
      false