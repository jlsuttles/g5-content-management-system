G5ClientHub.DropTargetAddView = Ember.View.extend G5ClientHub.Droppable,
  tagName: "span"
  classNames: ["drop-target drop-target-add"]
  classNameBindings: ["dropTargetActive"]
  helpText: null

  # This will determine which class (if any) you should add to
  # the view when you are in the process of dragging an item.
  dropTargetActive: ( ->
    if Ember.isEmpty(@get("dragContext"))
      @set "helpText", "(Add Zone)"
      return null
    else
      @set "helpText", "(Drop to Add)"
      "drop-target-active"
  ).property("dragContext")

  # Overrides G5ClientHub.Droppable#drop
  drop: (event) ->
    # Get the view that was dropped
    viewId = event.originalEvent.dataTransfer.getData("Text")
    view = Ember.View.views[viewId]
    dropTarget = @get("content")

    if view.content.get("id") == null
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

    # Reloads iFrame preview
    url = $('iframe').prop('src')
    $('iframe').prop('src', url)

    # Call G5ClientHub.Droppable#drop
    @_super event
