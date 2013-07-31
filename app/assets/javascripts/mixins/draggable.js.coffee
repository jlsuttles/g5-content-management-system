App.Draggable = Ember.Mixin.create
  attributeBindings: "draggable"
  draggable: "true"

  dragStart: (event) ->
    dataTransfer = event.originalEvent.dataTransfer
    dataTransfer.setData "Text", @get("elementId")

  dragEnd: (event) ->
    event.preventDefault()
    false
