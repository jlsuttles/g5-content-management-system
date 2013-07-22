G5ClientHub.Checkbox = Ember.Checkbox.extend
  change: ->
    @get("controller.content").save()
