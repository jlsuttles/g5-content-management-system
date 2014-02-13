App.GardenWebLayoutsController = Ember.ArrayController.extend
  needs: ["webLayout"]

  selectedLayout: ( ->
    @get("controllers.webLayout.model")
  ).property("controllers.webLayout.model")

  actions:
    update: (webLayout) ->
      currentWebLayout = @get("controllers.webLayout.model")
      # TODO: update gardenWebLayoutId or relation instead
      currentWebLayout.set("url", webLayout.get("url"))
      currentWebLayout.save()
