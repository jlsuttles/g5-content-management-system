App.Client = DS.Model.extend
  locations: DS.hasMany("App.Location")
  websites: DS.hasMany("App.Website")
  urn: DS.attr("string")
  name: DS.attr("string")
