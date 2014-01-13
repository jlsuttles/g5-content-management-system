App.WebsiteRoute = Ember.Route.extend
  model: (params) ->
    slug = params["website_slug"]
    websites = App.Website.find({})
    websites.one "didLoad", ->
      website = null
      websites.forEach (x) -> website = x if x.get("slug") is slug
      websites.resolve website
    websites

  setupController: (controller, model) ->
    controller.set("model", model)
    # setup other controllers
    @controllerFor("websiteTemplate").set("model", model.get("websiteTemplate"))
    @controllerFor("websiteWebHomeTemplate").set("model", model.get("webHomeTemplate"))
    @controllerFor("websiteWebPageTemplates").set("model", model.get("webPageTemplates"))
    @controllerFor("websiteWebPageTemplatesInTrash").set("model", model.get("webPageTemplates"))

  serialize: (model) ->
    website_slug: model.get "slug"
