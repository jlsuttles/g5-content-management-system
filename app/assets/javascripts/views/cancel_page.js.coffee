App.CancelPage = Ember.View.extend
  click: (e) ->
    toggleBtn = $(e.currentTarget)
    toggleBtn.parents(".flip-container").toggleClass "flipped"
    e.preventDefault()