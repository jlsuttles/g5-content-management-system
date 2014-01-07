App.WebsiteWebPageTemplatesView = Ember.View.extend JQ.Sortable,
  # JQ.Sortable uiEvent
  update: (event) ->
    # Save the new display order position
    indexes = {}
    $(this).find(".sortable-item").each (index) ->
      indexes[$(this).data("id")] = index
    # Tell controller to update models with new positions
    @get("controller").updateSortOrder indexes
