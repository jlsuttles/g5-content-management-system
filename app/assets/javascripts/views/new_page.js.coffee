App.NewPage = Ember.View.extend
  click: ->
    $("html, body").animate
      scrollTop: $(document).height()
    , 1000
