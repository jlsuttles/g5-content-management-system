G5ClientHub.WebsiteTemplate = DS.Model.extend
  createdAt: DS.attr("date"),
  updatedAt: DS.attr("date"),
  disabled: DS.attr("boolean"),
  name: DS.attr("string"),
  slug: DS.attr("string"),
  template: DS.attr("boolean"),
  title: DS.attr("string"),
  websiteId: DS.attr("number"),
  webLayout: DS.belongsTo("G5ClientHub.WebLayout"),
  webTheme: DS.belongsTo("G5ClientHub.WebTheme")
