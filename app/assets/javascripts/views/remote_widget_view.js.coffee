App.RemoteWidgetView = Ember.View.extend JQ.Draggable,
  tagName: "li"
  classNames: ["thumb", "widget", "remote-widget"]
  classNameBindings: ["dasherizedName"]
  templateName: "_remote_widget"
  # JQ.Draggable uiOptions
  revert: true
  zIndex: 1000

  dasherizedName: ( ->
    name = @get("content.name")
    name.dasherize() if name
  ).property("content.name")
