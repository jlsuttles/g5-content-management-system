App.LocationsController = Ember.ArrayController.extend
  actions:
    deploy: (model) ->
      url = "/websites/" + model.get("website.id") + "/deploy"
      $("<form action='" + url + "' method='post'></form>").submit()
      false
    updateGardenWebLayouts: ->
      url = "/api/v1/garden_web_layouts"
      $("<form action='" + url + "' method='post'></form>").submit()
      false
    updateGardenWebThemes: ->
      url = "/api/v1/garden_web_themes"
      $("<form action='" + url + "' method='post'></form>").submit()
      false
    updateGardenWidgets: ->
      url = "/api/v1/garden_widgets"
      $("<form action='" + url + "' method='post'></form>").submit()
      false
