G5ClientHub.Draggable = Ember.Mixin.create
  attributeBindings: "draggable"
  draggable: "true"
  dragStart: (event) ->
    dataTransfer = event.originalEvent.dataTransfer
    dataTransfer.setData "Text", @get("elementId")

G5ClientHub.Droppable = Ember.Mixin.create
  dropEnter: (event) ->
    event.preventDefault()
    false
  dropOver: (event) ->
    event.preventDefault()
    false
  drop: (event) ->
    event.preventDefault()
    false
