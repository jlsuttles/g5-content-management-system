G5ClientHub.RemoteWebLayoutView = Ember.View.extend G5ClientHub.Droppable,
  tagName: "span"

  isSelected: ( ->
    @get("controller.selectedLayout.name") is @get("content.name")
  ).property("controller.selectedLayout.name")
