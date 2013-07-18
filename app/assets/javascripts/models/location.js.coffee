G5ClientHub.Location = DS.Model.extend
  webTemplate: DS.belongsTo("G5ClientHub.WebsiteTemplate"),
  urn: DS.attr("string")
