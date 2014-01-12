App.WebsiteController = Ember.ObjectController.extend
  confirmEmptyTrash: false

  actions:
    deploy: (model) ->
      url = "/websites/" + model.id + "/deploy"
      $("<form action='" + url + "' method='post'></form>").submit()
      false
    confirmEmptyTrash: ->
      @set "confirmEmptyTrash", not @get("confirmEmptyTrash")
    emptyTrash: ->
      @beginPropertyChanges()
      @get("webPageTemplates").filterBy("inTrash", true).forEach (item) ->
        item.deleteRecord()
      @endPropertyChanges()
      @get("store").save()
      @set "confirmEmptyTrash", false
