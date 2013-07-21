G5ClientHub.RemoteWidgetsController = Ember.ArrayController.extend
  currentDragItem: ( ->
    @findProperty "isDragging", true
  ).property("@each.isDragging")
