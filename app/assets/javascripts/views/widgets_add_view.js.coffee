App.WidgetsAddView = Ember.View.extend JQ.Droppable,
  tagName: "span"
  classNames: ["drop-target drop-target-add"]
  classNameBindings: ["dropTargetActive"]
  templateName: ["_widgets_add"]
  helpText: null
  # JQ.Droppable uiOptions
  accept: ".new-widget"

  # This will determine which class (if any) you should add to
  # the view when you are in the process of dragging an item.
  dropTargetActive: ( ->
    if Ember.isEmpty(@get("dragContext"))
      @set "helpText", "Drag here to add"
      return null
    else
      @set "helpText", "Drag here to add"
      "drop-target-active"
  ).property("dragContext")

  # JQ.Droppable uiEvent
  drop: (event, ui) ->
    # Make sure ui is present before continuing
    return unless ui?
    # Get the dropped Ember view
    droppedViewId = ui.draggable.attr("id")
    droppedView = Ember.View.views[droppedViewId]
    widgets = @get("content")
    console.log @get("content")

    # Create a new record
    widgets.createRecord
      url: droppedView.content.get("url")
    .save()
