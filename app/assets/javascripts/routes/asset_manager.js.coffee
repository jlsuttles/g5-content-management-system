App.AssetManagerRoute = Ember.Route.extend
  model: (params) ->
    slug = params["website_slug"]
    assets = App.Website.find({})
    websites.one "didLoad", ->
      website = null
      websites.forEach (x) -> website = x if x.get("slug") is slug
      websites.resolve website
    websites

  setupController: (controller, model) ->
    controller.set("model", model)
    # setup other controllers

  serialize: (model) ->
    website_slug: model.get "slug"

