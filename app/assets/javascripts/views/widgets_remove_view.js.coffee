App.WidgetsRemoveView = Ember.View.extend JQ.Droppable,
  tagName: "span"
  classNames: ["drop-target drop-target-remove"]
  classNameBindings: ["dropTargetActive"]
  templateName: ["_widgets_remove"]
  # JQ.Droppable uiOptions
  accept: ".existing-widget"
  activeClass: "drop-target-active"

  # JQ.Droppable uiEvent
  drop: (event, ui) ->
    # Make sure ui is present before continuing
    return unless ui?
    # Get the dropped Ember view
    droppedViewId = ui.draggable.attr("id")
    droppedView = Ember.View.views[droppedViewId]
    # Destroy the dropped view's content
    droppedView.get("content").one "didDelete", ui, ->
      @draggable.remove()
    droppedView.set("content.isRemoved", true)
