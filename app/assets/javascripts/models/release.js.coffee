App.Release = DS.Model.extend
  release_id:  DS.attr("string")
  version:     DS.attr("string")
  created_at:  DS.attr("date")
  description: DS.attr("string")
  user:        DS.attr("string")
