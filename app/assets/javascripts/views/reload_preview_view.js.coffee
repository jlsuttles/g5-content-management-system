G5ClientHub.ReloadPreviewView = Ember.View.extend
  click: ->
    # Reloads iFrame URL
    url = $('iframe').prop('src')
    $('iframe').prop('src', url)
