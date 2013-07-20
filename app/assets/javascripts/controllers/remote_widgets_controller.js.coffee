G5ClientHub.RemoteWidgetsController = Ember.ArrayController.extend
  needs: ["widgets"]

  addWidget: (remoteWidget) ->
    widgets = @get("controllers.widgets.model")
    widgets.createRecord
      url: remoteWidget.get("url")
    .save()

  currentDragItem: -> (
    console.log "currentDragItem"
    @findProperty "isDragging", true
  ).property("@each.isDragging").cacheable()

  widgetsInDropTarget: -> (
    console.log "widgetsInDropTarget"
    @filterProperty "isAdded", true
  ).property("@each.isAdded").cacheable()
