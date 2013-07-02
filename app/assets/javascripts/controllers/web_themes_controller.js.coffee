G5ClientHub.WebThemesController = Ember.ArrayController.extend
  addWebTheme: (webTheme) ->
    websiteTemplate = @controllerFor("websiteTemplate").get("model")
    websiteTemplate.set("webTheme", webTheme)