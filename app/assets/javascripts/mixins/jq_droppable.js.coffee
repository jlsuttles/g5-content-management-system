JQ.Droppable = Ember.Mixin.create JQ.Base,
  uiType: "droppable"
  uiOptions: ["accept", "activeClass", "addClasses", "disabled", "greedy",
  "hoverClass", "scope", "tolerance"]
  uiEvents: ["activate", "create", "deactivate", "drop", "out", "over"]
