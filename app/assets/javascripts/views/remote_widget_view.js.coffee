App.RemoteWidgetView = Ember.View.extend JQ.Draggable,
  tagName: "li"
  classNames: ["thumb", "widget"]
  classNameBindings: ["dasherizedName"]
  templateName: "_remote_widget"
  # JQ.Draggable options
  revert: true

  dasherizedName: ( ->
    name = @get("content.name")
    name.dasherize() if name
  ).property("content.name")
