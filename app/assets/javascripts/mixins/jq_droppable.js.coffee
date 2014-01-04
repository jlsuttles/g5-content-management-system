JQ.Droppable = Ember.Mixin.create JQ.Base,
  uiType: "droppable"
  uiOptions: ["accept", "activeClass", "addClasses", "disabled", "greedy",
  "hoverClass", "scope", "tolerance"]
  uiEvents: ["activate", "create", "deactivate", "drop", "out", "over"]

  drop: (event, ui) ->
    # TODO: need preventDefault?
    event.preventDefault()
