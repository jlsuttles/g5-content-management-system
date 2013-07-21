G5ClientHub.FooterWidgetsDropTargetView = Ember.View.extend G5ClientHub.Droppable,
  tagName: "div" # create a div
  classNames: ["footerWidgetsDropTarget"] # that always has this class
  classNameBindings: ["dropTargetAction"] # and has a class that changes
  helpText: null # initialize help text

  # This will determine which class (if any) you should add to
  # the view when you are in the process of dragging an item.
  dropTargetAction: Ember.computed((key, value) ->
    if Ember.isEmpty(@get("dragContext"))
      @set "helpText", "(Drop Zone)"
      return null
    unless @get("dragContext.isAddedToFooterWidgets")
      @set "helpText", "(Drop to Add)"
      "drop-target-add"
    else if @get("dragContext.isAddedToFooterWidgets")
      @set "helpText", "(Drop to Remove)"
      "drop-target-remove"
    else
      @set "helpText", "(Drop Zone)"
      null
  ).property("dragContext").cacheable()

  # Overrides G5ClientHub.Droppable#drop
  drop: (event) ->
    viewId = event.originalEvent.dataTransfer.getData("Text")
    view = Ember.View.views[viewId]

    @get("content").createRecord
      url: view.content.get("url")
    .save()

    # Set view properties
    # Must be within `Ember.run.next` to always work
    Ember.run.next this, ->
      view.set "content.isAddedToFooterWidgets", not view.get("content.isAddedToFooterWidgets")

    @_super event
