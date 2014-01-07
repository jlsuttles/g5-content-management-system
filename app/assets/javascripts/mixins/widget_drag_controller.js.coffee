App.WidgetDragController = Ember.Mixin.create
  needs: ["remoteWidgets"]

  currentDragAddItem: ( ->
    @get("controllers.remoteWidgets.currentDragItem")
  ).property("controllers.remoteWidgets.currentDragItem")

  currentDragRemoveItem: ( ->
    @findProperty "isDragging", true
  ).property("@each.isDragging")
