App.Asset = DS.Model.extend
  website: DS.belongsTo("App.Website")
  name: DS.attr("string")
  url: DS.attr("string")
