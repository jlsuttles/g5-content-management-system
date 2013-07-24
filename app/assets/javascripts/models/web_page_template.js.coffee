G5ClientHub.WebPageTemplate = DS.Model.extend
  website: DS.belongsTo("G5ClientHub.Website")
  webLayout: DS.belongsTo("G5ClientHub.WebLayout")
  webTheme: DS.belongsTo("G5ClientHub.WebTheme")
  mainWidgets: DS.hasMany("G5ClientHub.MainWidget")
  previewUrl: DS.attr("string")
