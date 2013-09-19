App.WebLayout = DS.Model.extend App.ReloadIframe,
  websiteTemplate: DS.belongsTo("App.WebsiteTemplate")
  name: DS.attr("string")
  thumbnail: DS.attr("string")
  url: DS.attr("string")
  title: "Layouts"
