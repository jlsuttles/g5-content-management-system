G5ClientHub.Website = DS.Model.extend
  location: DS.belongsTo("G5ClientHub.Location"),
  urn: DS.attr("string")
