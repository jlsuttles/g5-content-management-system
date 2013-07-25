G5ClientHub.ColorPickerView = Ember.View.extend
  tagName: "form"

  didInsertElement: ->
    $("input.color").spectrum
      preferredFormat: "hex"
      showInput: true
