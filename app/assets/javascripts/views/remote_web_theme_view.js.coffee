App.RemoteWebThemeView = Ember.View.extend App.Droppable,
  tagName: "span"

  isSelected: ( ->
    @get("controller.selectedTheme.name") is @get("content.name")
  ).property("controller.selectedTheme.name")
