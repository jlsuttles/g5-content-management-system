G5ClientHub.LogoWidgetsDropTargetView = Ember.View.extend G5ClientHub.Droppable,
  tagName: "div" # create a div
  classNames: ["logoWidgetsDropTarget"] # that always has this class
  classNameBindings: ["dropTargetAction"] # and has a class that changes
  helpText: null # initialize help text

  # This will determine which class (if any) you should add to
  # the view when you are in the process of dragging an item.
  dropTargetAction: Ember.computed((key, value) ->
    if Ember.isEmpty(@get("dragContext"))
      @set "helpText", "(Drop Zone)"
      return null
    unless @get("dragContext.isAddedToLogoWidgets")
      @set "helpText", "(Drop to Add)"
      "drop-target-add"
    else if @get("dragContext.isAddedToLogoWidgets")
      @set "helpText", "(Drop to Remove)"
      "drop-target-remove"
    else
      @set "helpText", "(Drop Zone)"
      null
  ).property("dragContext")

  # Overrides G5ClientHub.Droppable#drop
  drop: (event) ->
    viewId = event.originalEvent.dataTransfer.getData("Text")
    view = Ember.View.views[viewId]

    if view.content.get("id") == null
      console.log "create record"
      @get("content").createRecord
        url: view.content.get("url")
      .save()
    else
      console.log "update record"
      @set("content", view.content).save()

    # Set view properties
    # Must be within `Ember.run.next` to always work
    Ember.run.next this, ->
      view.set "content.isAddedToLogoWidgets", not view.get("content.isAddedToLogoWidgets")

    @_super event
