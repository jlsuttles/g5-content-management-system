App.WidgetsAddView = Ember.View.extend JQ.Droppable,
  tagName: "span"
  classNames: ["drop-target drop-target-add"]
  classNameBindings: ["dropTargetActive"]
  templateName: ["_widgets_add"]
  # JQ.Droppable uiOptions
  accept: ".new-widget"
  activeClass: "drop-target-active"
  tolerance: "touch"

  # JQ.Droppable uiEvent
  drop: (event, ui) ->
    # Make sure ui is present before continuing
    return unless ui?
    # Get the dropped Ember view
    droppedViewId = ui.draggable.attr("id")
    droppedView = Ember.View.views[droppedViewId]
    # Create new record using url
    gardenWidgetId = droppedView.content.get("id")
    @get("content").createRecord
      gardenWidgetId: gardenWidgetId
    .save()
