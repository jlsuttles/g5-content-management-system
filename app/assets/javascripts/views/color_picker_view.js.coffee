App.ColorPickerView = Ember.View.extend
  tagName: "form"

  primaryColorDidChange: ( ->
    Ember.run.next this, ->
      $("input.color").spectrum
        preferredFormat: "hex"
        showInput: true
  ).observes("controller.primaryColor")
