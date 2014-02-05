App.Website = DS.Model.extend App.ReloadIframe,
  location: DS.belongsTo("App.Location")
  websiteTemplate: DS.belongsTo("App.WebsiteTemplate")
  webHomeTemplate: DS.belongsTo("App.WebHomeTemplate")
  webPageTemplates: DS.hasMany("App.WebPageTemplate")
  name: DS.attr("string")
  urn: DS.attr("string")
  slug: DS.attr("string")
  herokuUrl: DS.attr("string")
