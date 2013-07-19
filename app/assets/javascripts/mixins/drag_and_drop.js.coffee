G5ClientHub.Draggable = Ember.Mixin.create
  attributeBindings: "draggable"
  draggable: "true"
  dragStart: (event) ->
    console.log "dragStart"
    dataTransfer = event.originalEvent.dataTransfer
    dataTransfer.setData "Text", @get("elementId")

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
