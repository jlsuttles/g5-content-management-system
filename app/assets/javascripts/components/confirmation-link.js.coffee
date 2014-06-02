App.ConfirmationLinkComponent = Ember.Component.extend
  tagName: ""
  classes: ""
  actions:
    showConfirmation: ->
      @toggleProperty "isShowingConfirmation"
      userConfirm = confirm(@get("message"))
      if userConfirm
        @sendAction "action", @get("param")
      else
      return

    confirm: ->
      @toggleProperty "isShowingConfirmation"
      @sendAction "action", @get("param")
      return

