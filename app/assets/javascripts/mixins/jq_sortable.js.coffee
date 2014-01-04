JQ.Sortable = Ember.Mixin.create JQ.Base,
  uiType: "sortable"
  uiOptions: ["appendTo", "axis", "cancel", "connectWith", "containment",
  "cursor", "cursorAt", "delay", "disabled", "distance", "dropOnEmpty",
  "forceHelperSize", "forcePlaceholderSize", "grid", "handle", "helper",
  "items", "opacity", "placeholder", "revert", "scroll", "scrollSensitivity",
  "scrollSpeed", "tolerance", "zIndex"]
  uiEvents: ["activate", "beforeStop", "change", "create", "deactivate", "out",
  "over", "receive", "remove", "sort", "start", "stop", "update"]

  update: (event) ->
    # Save the new display order position
    indexes = {}
    $(this).find(".sortable-item").each (index) ->
      indexes[$(this).data("id")] = index
    # Tell controller to update models with new positions
    @get("controller").updateSortOrder indexes
