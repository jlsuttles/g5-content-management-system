App.SortableWidgetsController = Ember.ArrayController.extend
  sortProperties: ["displayOrder"]

  updateSortOrder: (indexes) ->
    @beginPropertyChanges()
    @get("content").forEach (item) ->
      if item? and item.get("currentState.stateName") != "root.deleted.saved"
        if item.get("isRemoved")
          item.deleteRecord()
        else
          # Get the new display order position
          index = indexes[item.get("id")]
          # Set display order position
          item.set "displayOrderPosition", index
    @endPropertyChanges()
    @get("store").save()
