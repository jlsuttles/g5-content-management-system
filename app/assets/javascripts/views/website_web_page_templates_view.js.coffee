App.WebsiteWebPageTemplatesView = Ember.View.extend JQ.Sortable,
  classNames: ["web-page-templates"]
  # JQ.Sortable uiOptions
  connectWith: ".web-page-templates-in-trash"
  revert: true

  # JQ.Sortable uiEvent
  update: (event, ui) ->
    console.log "NotInTrash#update"
    console.log ui
    # Make sure ui is present before continuing
    if ui? and ui.item?
      console.log "NotInTrash#update ui.item present"
      # Get the dropped Ember view
      droppedViewId = ui.item.attr("id")
      droppedView = Ember.View.views[droppedViewId]
      # Set view not in trash
      droppedView.content.set("inTrash", not droppedView.content.get("inTrash"))
      droppedView.content.save()

    # Save the new display order position
    indexes = {}
    @$(".web-page-template").each (index) ->
      indexes[$(this).data("id")] = index
    # Tell controller to update models with new positions
    @get("controller").updateSortOrder indexes
