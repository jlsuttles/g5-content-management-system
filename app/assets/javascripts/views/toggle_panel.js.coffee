App.TogglePanelView = Ember.View.extend
  tagName: "a"
  classNames: ["btn--toggle"]
  attributeBindings: ['href']
  href: '#'

  click: (e) ->
    $(this).find('.toggle-panel-text')
      .toggle()
      .parent().parent().next()
      .slideToggle()
    return false
