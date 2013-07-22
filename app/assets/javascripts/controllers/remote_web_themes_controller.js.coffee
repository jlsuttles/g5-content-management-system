G5ClientHub.RemoteWebThemesController = Ember.ArrayController.extend
  needs: ["webTheme"]

  update: (webTheme) ->
    currentWebTheme = @get("controllers.webTheme.model")
    currentWebTheme.set("url", webTheme.get("url"))
    currentWebTheme.save()

    currentWebTheme.on 'didUpdate', ->
      # Reloads iFrame preview
      url = $('iframe').prop('src')
      $('iframe').prop('src', url)

  selectedTheme: ( ->
    @get("controllers.webTheme.model")
  ).property("controllers.webTheme.model")
