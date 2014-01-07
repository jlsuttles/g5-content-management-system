App.WidgetsAddView = Ember.View.extend JQ.Droppable,
  tagName: "span"
  classNames: ["drop-target drop-target-add"]
  classNameBindings: ["dropTargetActive"]
  templateName: ["_widgets_add"]
  # JQ.Droppable uiOptions
  accept: ".new-widget"

  # This will determine which class (if any) you should add to
  # the view when you are in the process of dragging an item.
  dropTargetActive: ( ->
    if Ember.isEmpty(@get("dragContext"))
      return null
    else
      "drop-target-active"
  ).property("dragContext")

  # JQ.Droppable uiEvent
  drop: (event, ui) ->
    # Make sure ui is present before continuing
    return unless ui?
    # Get the dropped Ember view
    droppedViewId = ui.draggable.attr("id")
    droppedView = Ember.View.views[droppedViewId]
    # Create new record using url
    url = droppedView.content.get("url")
    @get("content").createRecord
      url: url
    .save()
