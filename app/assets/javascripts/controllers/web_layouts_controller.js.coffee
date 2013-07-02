G5ClientHub.WebLayoutsController = Ember.ArrayController.extend
  addWebLayout: (webLayout) ->
    websiteTemplate = @controllerFor("websiteTemplate").get("model")
    websiteTemplate.set("webLayout", webLayout)