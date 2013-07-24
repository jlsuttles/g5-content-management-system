G5ClientHub.MainWidget = DS.Model.extend G5ClientHub.ReloadIframe,
  webHomeTemplate: DS.belongsTo("G5ClientHub.WebsiteTemplate")
  webPageTemplate: DS.belongsTo("G5ClientHub.WebPageTemplate")
  name: DS.attr("string")
  thumbnail: DS.attr("string")
  url: DS.attr("string")
  section: DS.attr("string")
