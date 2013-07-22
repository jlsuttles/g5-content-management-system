G5ClientHub.RemoteWebThemesController = Ember.ArrayController.extend
  needs: ["webTheme"]

  update: (webTheme) ->
    currentWebTheme = @get("controllers.webTheme.model")
    currentWebTheme.set("url", webTheme.get("url"))
    currentWebTheme.save()

  selectedTheme: ( ->
    @get("controllers.webTheme.model")
  ).property("controllers.webTheme.model")