App.WebHomeTemplate = DS.Model.extend
  website: DS.belongsTo("App.Website")
  mainWidgets: DS.hasMany("App.MainWidget")
  herokuUrl: DS.attr("string")
  previewUrl: DS.attr("string")
  name: DS.attr("string")
  slug: DS.attr("string")
  title: DS.attr("string")
  disabled: DS.attr("boolean")
  isWebHomeTemplate: true
