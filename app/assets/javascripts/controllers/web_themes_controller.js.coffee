G5ClientHub.WebThemesController = Ember.ArrayController.extend
  needs: ["websiteTemplate"]

  addWebTheme: (webTheme) ->
    websiteTemplate = @get("controllers.websiteTemplate.model")
    websiteTemplate.set("webTheme", webTheme)
    websiteTemplate.get('transaction').commit()