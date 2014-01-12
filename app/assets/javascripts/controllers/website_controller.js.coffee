App.WebsiteController = Ember.ObjectController.extend
  confirmEmptyTrash: false

  actions:
    deploy: (model) ->
      url = "/websites/" + model.id + "/deploy"
      $("<form action='" + url + "' method='post'></form>").submit()
      false
    confirmEmptyTrash: ->
      @set "confirmEmptyTrash", not @get("confirmEmptyTrash")
