G5ClientHub.WebsiteTemplate = DS.Model.extend
  webLayout: DS.belongsTo("G5ClientHub.WebLayout"),
  webTheme: DS.belongsTo("G5ClientHub.WebTheme"),
  widgets: DS.hasMany("G5ClientHub.Widget"),
  location: DS.belongsTo("G5ClientHub.Location")
