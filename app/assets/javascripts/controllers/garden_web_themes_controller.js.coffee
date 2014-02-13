App.GardenWebThemesController = Ember.ArrayController.extend
  needs: ["webTheme"]

  selectedTheme: ( ->
    @get("controllers.webTheme.model")
  ).property("controllers.webTheme.model")

  actions:
    update: (webTheme) ->
      currentWebTheme = @get("controllers.webTheme.model")
      # TODO: update gardenWebLayoutId or relation instead
      currentWebTheme.set("url", webTheme.get("url"))
      currentWebTheme.save()
