App.RemoteWidgetView = Ember.View.extend(DragNDrop.Draggable,
  tagName: "span"
  
  # .setDragImage (in #dragStart) requires an HTML element as the first argument
  # so you must tell Ember to create the view and it's element and then get the 
  # HTML representation of that element.
  dragIconElement: Ember.View.create(
    attributeBindings: ["src"]
    tagName: "img"
    src: "http://twitter.com/api/users/profile_image/twitter"
  ).createElement().get("element")
  
  dragStart: (event) ->
    @_super event
    
    # Let the controller know this view is dragging
    @setPath "content.isDragging", true
    
    # Set the drag image and location relative to the mouse/touch event
    dataTransfer = event.originalEvent.dataTransfer
    dataTransfer.setDragImage @get("dragIconElement"), 24, 24

  dragEnd: (event) ->
    
    # Let the controller know this view is done dragging
    @setPath "content.isDragging", false
)