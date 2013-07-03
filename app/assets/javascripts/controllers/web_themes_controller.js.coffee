G5ClientHub.WebThemesController = Ember.ArrayController.extend
  needs: ["webTheme"]

  update: (webTheme) ->
    currentWebTheme = @get("controllers.webTheme.model")
    currentWebTheme.set("url", webTheme.get("url"))
    currentWebTheme.get("transaction").commit()
