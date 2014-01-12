App.WebsiteWebPageTemplatesView = Ember.View.extend JQ.Sortable,
  classNames: ["web-page-templates"]
  connectWith: ".web-page-templates-in-trash"

  # JQ.Sortable uiEvent
  update: (event, ui) ->
    # Make sure ui is present before continuing
    if ui? && ui.draggable?
      # Get the dropped Ember view
      droppedViewId = ui.draggable.attr("id")
      droppedView = Ember.View.views[droppedViewId]
      # Set view not in trash
      droppedView.content.set("inTrash", true)
      droppedView.content.save()

    # Save the new display order position
    indexes = {}
    @$(".web-page-template").each (index) ->
      indexes[$(this).data("id")] = index
    # Tell controller to update models with new positions
    @get("controller").updateSortOrder indexes
