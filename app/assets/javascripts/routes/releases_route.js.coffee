App.ReleasesRoute = Ember.Route.extend
  model: ->
    return this.store.find("release")
