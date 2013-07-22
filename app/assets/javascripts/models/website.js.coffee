G5ClientHub.Website = DS.Model.extend
  location: DS.belongsTo("G5ClientHub.Location")
  webTemplate: DS.belongsTo("G5ClientHub.WebsiteTemplate")
  urn: DS.attr("string")
  customColors: DS.attr("boolean")
  primaryColor: DS.attr("string")
  secondaryColor: DS.attr("string")
