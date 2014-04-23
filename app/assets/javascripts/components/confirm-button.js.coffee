App.ConfirmButtonComponent = Ember.Component.extend
  actions:
    showConfirmation: ->
      @toggleProperty "isShowingConfirmation"
      return

    confirm: ->
      @toggleProperty "isShowingConfirmation"
      @sendAction "action", @get("param")
      return

