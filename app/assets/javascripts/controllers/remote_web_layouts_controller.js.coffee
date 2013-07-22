G5ClientHub.RemoteWebLayoutsController = Ember.ArrayController.extend
  needs: ["webLayout"]

  update: (webLayout) ->
    currentWebLayout = @get("controllers.webLayout.model")
    currentWebLayout.set("url", webLayout.get("url"))
    currentWebLayout.save()

    currentWebLayout.on 'didUpdate', ->
      # Reloads iFrame preview
      url = $('iframe').prop('src')
      $('iframe').prop('src', url)

  selectedLayout: ( ->
    @get("controllers.webLayout.model")
  ).property("controllers.webLayout.model")
