App.ColorPickerView = Ember.View.extend
  tagName: "form"

  didInsertElement: ->
    $("input.color").spectrum
      preferredFormat: "hex"
      showInput: true
