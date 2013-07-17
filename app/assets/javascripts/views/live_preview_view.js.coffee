G5ClientHub.LivePreviewView = Ember.View.extend
  click: ->
    url = $('iframe').prop('src')
    $('iframe').prop('src', url)