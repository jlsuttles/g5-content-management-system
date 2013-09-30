App.CardFlipper = Ember.View.extend
  tagName: "a"
  classNames: ["card-corner", "card-flip"]
  attributeBindings: ['href']
  href: '#'
  title: "Page Settings"

  click: (e) ->
    toggleBtn = $(e.currentTarget)
    toggleBtn.parents(".flip-container").toggleClass "flipped"
    e.preventDefault()