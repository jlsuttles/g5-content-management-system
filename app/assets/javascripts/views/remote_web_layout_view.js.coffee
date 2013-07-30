App.RemoteWebLayoutView = Ember.View.extend App.Droppable,
  tagName: "span"

  isSelected: ( ->
    @get("controller.selectedLayout.name") is @get("content.name")
  ).property("controller.selectedLayout.name")
