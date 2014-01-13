App.WidgetsAddView = Ember.View.extend JQ.Droppable,
  tagName: "span"
  classNames: ["drop-target drop-target-add"]
  classNameBindings: ["dropTargetActive"]
  templateName: ["_widgets_add"]
  # JQ.Droppable uiOptions
  accept: ".new-widget"
  activeClass: "drop-target-active"

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
