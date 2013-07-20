G5ClientHub.RemoteWidgetsController = Ember.ArrayController.extend
  needs: ["widgets"]

  addWidget: (remoteWidget) ->
    widgets = @get("controllers.widgets.model")
    widgets.createRecord
      url: remoteWidget.get("url")
    .save()

  currentDragItem: ( ->
    console.log "currentDragItem"
    @findProperty "isDragging", true
  ).property("@each.isDragging")

  widgetsInDropTarget: ( ->
    console.log "widgetsInDropTarget"
    dropTargetItems = @filterProperty "isAdded", true
    console.log dropTargetItems
    unless Ember.isEmpty(dropTargetItems)
      dropTargetItems.sort (a, b) ->
        if (a.get("name").toLowerCase()) < (b.get("name").toLowerCase())
          -1
        else
          1
  ).property("@each.isAdded")
