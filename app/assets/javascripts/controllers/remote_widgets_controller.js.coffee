App.RemoteWidgetsController = Ember.ArrayController.extend
  actions: {
    currentDragItem: ( ->
      @findProperty "isDragging", true
    ).property("@each.isDragging")
  }
