App.Release = DS.Model.extend
  version:     DS.attr("string")
  created_at:  DS.attr("date")
  id:          DS.attr("string")
  description: DS.attr("string")
