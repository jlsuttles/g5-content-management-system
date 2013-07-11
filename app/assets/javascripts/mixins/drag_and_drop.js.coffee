DragAndDrop = Ember.Namespace.create()

DragAndDrop.cancel = (event) ->
  event.preventDefault()
  false

DragAndDrop.Draggable = Ember.Mixin.create
  attributeBindings: "draggable"
  draggable: "true"
  dragStart: (event) ->
    dataTransfer = event.originalEvent.dataTransfer
    dataTransfer.setData "Text", @get("elementId")

DragAndDrop.Droppable = Ember.Mixin.create
  dragEnter: DragAndDrop.cancel
  dragOver: DragAndDrop.cancel
  drop: (event) ->
    event.preventDefault()
    false