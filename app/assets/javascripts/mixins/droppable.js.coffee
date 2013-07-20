G5ClientHub.Droppable = Ember.Mixin.create
  dropEnter: (event) ->
    console.log "dropEnter"
    event.preventDefault()
    false

  dropOver: (event) ->
    console.log "dropOver"
    event.preventDefault()
    false

  drop: (event) ->
    console.log "drop"
    event.preventDefault()
    false
