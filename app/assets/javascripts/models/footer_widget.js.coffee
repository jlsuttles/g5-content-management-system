G5ClientHub.FooterWidget = DS.Model.extend G5ClientHub.ReloadIframe,
  websiteTemplate: DS.belongsTo("G5ClientHub.WebsiteTemplate")
  name: DS.attr("string")
  thumbnail: DS.attr("string")
  url: DS.attr("string")
  section: DS.attr("string")
