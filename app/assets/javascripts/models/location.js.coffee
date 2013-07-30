App.Location = DS.Model.extend
  urn: DS.attr("string")
  website: DS.belongsTo("App.Website")
