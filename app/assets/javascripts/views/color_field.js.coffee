G5ClientHub.ColorField = Ember.TextField.extend
  type: "color"

  change: ->
    @get("controller.content").save()
