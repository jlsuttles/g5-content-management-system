G5ClientHub.Droppable = Ember.Mixin.create
  dragEnter: (event) ->
    event.preventDefault()
    false

  dragOver: (event) ->
    event.preventDefault()
    false

  drop: (event) ->
    event.preventDefault()
    false
