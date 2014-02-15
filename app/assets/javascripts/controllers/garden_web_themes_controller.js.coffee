App.GardenWebThemesController = Ember.ArrayController.extend
  needs: ["webTheme"]

  selectedTheme: ( ->
    @get("controllers.webTheme.model")
  ).property("controllers.webTheme.model")

  actions:
    update: (gardenWebTheme) ->
      webTheme = @get("controllers.webTheme.model")
      webTheme.set("gardenWebThemeId", gardenWebTheme.get("id"))
      webTheme.save()
