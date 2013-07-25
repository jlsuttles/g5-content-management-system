G5ClientHub.Location = DS.Model.extend
  urn: DS.attr("string")
  website: DS.belongsTo("G5ClientHub.Website")
