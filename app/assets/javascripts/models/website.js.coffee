App.Website = DS.Model.extend App.ReloadIframe,
  urn: DS.attr("string")
  location: DS.belongsTo("App.Location")
  websiteTemplate: DS.belongsTo("App.WebsiteTemplate")
  customColors: DS.attr("boolean")
  primaryColor: DS.attr("string")
  secondaryColor: DS.attr("string")
