App.WebHomeTemplate = DS.Model.extend
  website: DS.belongsTo("App.Website")
  webLayout: DS.belongsTo("App.WebLayout")
  webTheme: DS.belongsTo("App.WebTheme")
  mainWidgets: DS.hasMany("App.MainWidget")
  previewUrl: DS.attr("string")
  name: DS.attr("string")
  slug: DS.attr("string")
  title: DS.attr("string")
  disabled: DS.attr("boolean")
  isWebHomeTemplate: true
