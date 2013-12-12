App.WebsiteController = Ember.ObjectController.extend
  actions:
    deploy: (model) ->
      url = "/websites/" + model.id + "/deploy"
      $("<form action='" + url + "' method='post'></form>").submit()
      false
