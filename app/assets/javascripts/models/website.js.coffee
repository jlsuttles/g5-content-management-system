G5ClientHub.Website = DS.Model.extend G5ClientHub.ReloadIframe,
  urn: DS.attr("string")
  location: DS.belongsTo("G5ClientHub.Location")
  websiteTemplate: DS.belongsTo("G5ClientHub.WebsiteTemplate")
  customColors: DS.attr("boolean")
  primaryColor: DS.attr("string")
  secondaryColor: DS.attr("string")
