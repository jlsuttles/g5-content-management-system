G5ClientHub.NavWidget = DS.Model.extend G5ClientHub.ReloadIframe,
  webTemplate: DS.belongsTo("G5ClientHub.WebsiteTemplate")
  name: DS.attr("string")
  thumbnail: DS.attr("string")
  url: DS.attr("string")
  section: DS.attr("string")
