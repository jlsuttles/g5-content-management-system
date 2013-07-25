G5ClientHub.RemoteWebThemeView = Ember.View.extend G5ClientHub.Droppable,
  tagName: "span"

  isSelected: ( ->
    @get("controller.selectedTheme.name") is @get("content.name")
  ).property("controller.selectedTheme.name")
