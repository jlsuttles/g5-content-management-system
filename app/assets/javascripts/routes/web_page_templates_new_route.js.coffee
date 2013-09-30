App.WebPageTemplatesNewRoute = Ember.Route.extend
  setupController: (controller, model) ->
    website = @controllerFor("website").get("model")
    # webTheme = website.get("websiteTemplate").get("webTheme")
    # webLayout = website.get("websiteTemplate").get("webLayout")

    controller.set "model", App.WebPageTemplate.createRecord
      website: website
      # webTheme: webTheme
      # webLayout: webLayout

  renderTemplate: ->
    this.render outlet: "newWebPageTemplate"