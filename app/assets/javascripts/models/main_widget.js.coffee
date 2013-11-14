App.MainWidget = DS.Model.extend App.ReloadIframe,
  webHomeTemplate: DS.belongsTo("App.WebHomeTemplate")
  webPageTemplate: DS.belongsTo("App.WebPageTemplate")
  name: DS.attr("string")
  thumbnail: DS.attr("string")
  url: DS.attr("string")
  section: DS.attr("string")
  displayOrder: DS.attr("number")
  displayOrderPosition: DS.attr("number")
