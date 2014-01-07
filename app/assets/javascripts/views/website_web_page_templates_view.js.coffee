App.WebsiteWebPageTemplatesView = Ember.View.extend JQ.Sortable,
  classNames: ["web-page-templates"]

  # JQ.Sortable uiEvent
  update: (event) ->
    # Save the new display order position
    indexes = {}
    @$(".web-page-template").each (index) ->
      indexes[$(this).data("id")] = index
    # Tell controller to update models with new positions
    @get("controller").updateSortOrder indexes
