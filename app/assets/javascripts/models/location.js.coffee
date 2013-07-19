G5ClientHub.Location = DS.Model.extend
  webTemplate: DS.belongsTo("G5ClientHub.WebsiteTemplate"),
  webHomeTemplate: DS.belongsTo("G5ClientHub.WebHomeTemplate"),
  urn: DS.attr("string")
