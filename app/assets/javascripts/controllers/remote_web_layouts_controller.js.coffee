App.RemoteWebLayoutsController = Ember.ArrayController.extend
  needs: ["webLayout"]

  actions: {
	  update: (webLayout) ->
	    currentWebLayout = @get("controllers.webLayout.model")
	    currentWebLayout.set("url", webLayout.get("url"))
	    currentWebLayout.save()

	  selectedLayout: ( ->
	    @get("controllers.webLayout.model")
	  ).property("controllers.webLayout.model")
  }