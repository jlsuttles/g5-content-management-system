App.TogglePanelView = Ember.View.extend
  tagName: "a"

  didInsertElement: ->
    $(".btn--toggle").on 'click', (e) ->
      $(this).find('.toggle-panel-text')
        .toggle()
        .parent().parent().next()
        .slideToggle()
      return false
