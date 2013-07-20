G5ClientHub.WebsiteTemplate = DS.Model.extend
  webLayout: DS.belongsTo("G5ClientHub.WebLayout"),
  webTheme: DS.belongsTo("G5ClientHub.WebTheme"),
  widgets: DS.hasMany("G5ClientHub.Widget"),
  location: DS.belongsTo("G5ClientHub.Location"),
  websiteUrn: DS.attr("string"),
  webHomeTemplateId: DS.attr("number")
  logoWidgets: DS.hasMany("G5ClientHub.Widget"),
  phoneWidgets: DS.hasMany("G5ClientHub.Widget"),
  btnWidgets: DS.hasMany("G5ClientHub.Widget"),
  navWidgets: DS.hasMany("G5ClientHub.Widget"),
  asideWidgets: DS.hasMany("G5ClientHub.Widget"),
  footerWidgets: DS.hasMany("G5ClientHub.Widget")
