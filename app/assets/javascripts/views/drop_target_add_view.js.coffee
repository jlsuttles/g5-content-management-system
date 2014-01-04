App.DropTargetAddView = Ember.View.extend JQ.Droppable,
  tagName: "span"
  classNames: ["drop-target drop-target-add"]
  classNameBindings: ["dropTargetActive"]
  helpText: null

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

  drop: (event, ui) ->
    # Get the view that was dropped
    viewId = ui.draggable.attr("id")
    view = Ember.View.views[viewId]
    dropTarget = @get("content")

    if view.content.get("id") is view.content.get("name")
      console.log "create record"
      dropTarget.createRecord
        url: view.content.get("url")
      .save()
    else
      console.log "update record"
      # TODO: do nothing if already in this section
      # TODO: update instead of create
      dropTarget.createRecord
        url: view.content.get("url")
      .save()
      view.content.deleteRecord()
      view.content.save()
