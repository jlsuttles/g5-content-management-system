G5ClientHub.Location = DS.Model.extend
  webTemplate: DS.belongsTo("G5ClientHub.WebsiteTemplate")
  webHomeTemplateId: DS.attr("string")
  websiteId: DS.attr("string")
  urn: DS.attr("string")
