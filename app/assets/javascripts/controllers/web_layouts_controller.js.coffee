G5ClientHub.WebLayoutsController = Ember.ArrayController.extend
  needs: ["websiteTemplate"]

  addWebLayout: (webLayout) ->
    websiteTemplate = @get("controllers.websiteTemplate.model")
    websiteTemplate.set("webLayout", webLayout)