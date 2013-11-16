App.WebsiteRoute = Ember.Route.extend
  model: (params) ->
    websites = App.Website.find({slug: params["website_slug"]})
    websites.one "didLoad", ->
      websites.resolve websites.get("firstObject")
    websites

  setupController: (controller, model) ->
    controller.set("model", model)
    # setup other controllers
    @controllerFor("websiteTemplate").set("model", model.get("websiteTemplate"))
    @controllerFor("webHomeTemplate").set("model", model.get("webHomeTemplate"))
    @controllerFor("webPageTemplates").set("model", model.get("webPageTemplates"))

  serialize: (model) ->
    website_slug: model.get "slug"
