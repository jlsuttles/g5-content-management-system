G5ClientHub.Checkbox = Ember.Checkbox.extend
  change: ->
    checkbox = @get("controller.content")
    checkbox.save()

    checkbox.on 'didUpdate', ->
      # Reloads iFrame preview
      url = $('iframe').prop('src')
      $('iframe').prop('src', url)
