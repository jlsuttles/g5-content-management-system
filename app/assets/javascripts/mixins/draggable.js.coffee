G5ClientHub.Draggable = Ember.Mixin.create
  attributeBindings: "draggable"
  draggable: "true"

  dragStart: (event) ->
    console.log "dragStart"
    dataTransfer = event.originalEvent.dataTransfer
    dataTransfer.setData "Text", @get("elementId")

  dragEnd: (event) ->
    console.log "dragEnd"
    event.preventDefault()
    false
