G5ClientHub.RemoteWidgetsController = Ember.ArrayController.extend
  needs: ["widgets"]

  update: (widget) ->
    currentWebTheme = @get("controllers.widgets")
    # currentWebTheme.set("url", webTheme.get("url"))
    # currentWebTheme.save()
    # currentWebTheme.on "didUpdate", ->
    #   currentWebTheme.reload()
