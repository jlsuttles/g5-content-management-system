App.WidgetViewToggle = Ember.View.extend
  tagName: "a"
  classNames: ["toggle-widget-view", "btn"]
  attributeBindings: ['href']
  href: '#'

  click: (e) ->
    toggleBtn = $(e.currentTarget)
    widgetViews = $('.widget-view')
    toggleBtn.find('.toggle-panel-text').toggle()
    widgetViews.toggleClass("visuallyhidden")
    false
