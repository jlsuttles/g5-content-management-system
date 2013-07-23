G5ClientHub.DraggableWidgetView = G5ClientHub.DraggableView.extend
  tagName: "li"
  classNames: ["thumb", "widget"]
  classNameBindings: ["dasherizedName"]

  dasherizedName: ( ->
    name = @get("content.name")
    name.dasherize() if name
  ).property("content.name")
