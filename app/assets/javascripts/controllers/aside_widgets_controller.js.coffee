App.AsideWidgetsController = Ember.ArrayController.extend
  sortProperties: ["displayOrder"]

  updateSortOrder: (indexes) ->
    @beginPropertyChanges()
    @get("content").forEach (item) ->
      # Get the new display order position
      index = indexes[item.get("id")]
      # Set display order position
      item.set "displayOrderPosition", index
    @endPropertyChanges()
    @get("store").save()
