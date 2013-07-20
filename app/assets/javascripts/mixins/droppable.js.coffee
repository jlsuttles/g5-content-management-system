G5ClientHub.Droppable = Ember.Mixin.create
  dragEnter: (event) ->
    console.log "dragEnter"
    event.preventDefault()
    false

  dragOver: (event) ->
    console.log "dragOver"
    event.preventDefault()
    false

  drop: (event) ->
    console.log "drop"
    event.preventDefault()
    false
