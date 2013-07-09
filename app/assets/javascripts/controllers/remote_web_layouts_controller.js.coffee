G5ClientHub.RemoteWebLayoutsController = Ember.ArrayController.extend
  needs: ["webLayout"]

  update: (webLayout) ->
    currentWebLayout = @get("controllers.webLayout.model")
    currentWebLayout.set("url", webLayout.get("url"))
    currentWebLayout.save()
