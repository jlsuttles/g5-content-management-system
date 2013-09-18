App.TogglePanelView = Ember.View.extend
  tagName: "a"
  classNames: ["btn--toggle"]
  attributeBindings: ['href']
  href: '#'

  click: (e) ->
    toggleBtn = $(e.currentTarget)
    toggleBtn.find('.toggle-panel-text').toggle()
    toggleBtn.siblings().slideToggle()
    false
