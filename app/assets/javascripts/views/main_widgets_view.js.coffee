App.MainWidgetsView = Ember.View.extend
  didInsertElement: ->
    controller = @get("controller")
    @$(".sortable").sortable
      update: (event, ui) ->
        # Save the new display order position
        indexes = {}
        $(this).find(".sortable-item").each (index) ->
          indexes[$(this).data("id")] = index
        # Tell controller to update models with new positions
        controller.updateSortOrder indexes
