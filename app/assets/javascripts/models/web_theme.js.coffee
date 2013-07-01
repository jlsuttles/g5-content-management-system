G5ClientHub.WebTheme = DS.Model.extend
  createdAt: DS.attr("date"),
  updatedAt: DS.attr("date"),
  name: DS.attr("string"),
  colors: DS.attr("string"),
  url: DS.attr("string"),
  thumbnail: DS.attr("string"),
  stylesheets: DS.attr("string"),
  javascripts: DS.attr("string")
