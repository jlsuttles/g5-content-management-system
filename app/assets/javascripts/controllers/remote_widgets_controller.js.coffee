App.RemoteWidgetsController = Ember.ArrayController.extend
  currentDragItem: ( ->
    @findProperty "isDragging", true
  ).property("@each.isDragging")
