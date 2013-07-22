G5ClientHub.NavWidget = DS.Model.extend
  webTemplate: DS.belongsTo("G5ClientHub.WebsiteTemplate")
  name: DS.attr("string")
  thumbnail: DS.attr("string")
  url: DS.attr("string")
  section: DS.attr("string")
