App.Location = DS.Model.extend
  urn: DS.attr("string")
  name: DS.attr("string")
  website: DS.belongsTo("App.Website")
