G5ClientHub.ColorField = Ember.TextField.extend
  type: "color"

  change: ->
    colorField = @get("controller.content")
    colorField.save()

    colorField.on 'didUpdate', ->
      # Reloads iFrame preview
      url = $('iframe').prop('src')
      $('iframe').prop('src', url)
