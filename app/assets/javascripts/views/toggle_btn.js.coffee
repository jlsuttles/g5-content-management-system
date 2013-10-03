App.ToggleBtn = Ember.View.extend
  didInsertElement: ->
    new window.toggleSwitch($(".switch"))
