App.LocationsController = Ember.ArrayController.extend
  actions:
    deploy: (model) ->
      url = "/websites/" + model.get("website.id") + "/deploy"
      $form = $("<form action='" + url + "' method='post'></form>")
      $form.appendTo("body").submit()
      false
    updateGardenWebLayouts: ->
      url = "/api/v1/garden_web_layouts/update"
      $form = $("<form action='" + url + "' method='post'></form>")
      $form.appendTo("body").submit()
      false
    updateGardenWebThemes: ->
      url = "/api/v1/garden_web_themes/update"
      $form = $("<form action='" + url + "' method='post'></form>")
      $form.appendTo("body").submit()
      false
    updateGardenWidgets: ->
      url = "/api/v1/garden_widgets/update"
      $form = $("<form action='" + url + "' method='post'></form>")
      $form.appendTo("body").submit()
      false
