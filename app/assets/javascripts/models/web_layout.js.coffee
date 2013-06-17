G5ClientHub.WebLayout = DS.Model.extend
  createdAt: DS.attr("date"),
  updatedAt: DS.attr("date"),
  name: DS.attr("string"),
  html: DS.attr("string"),
  thumbnail: DS.attr("string"),
  stylesheets: DS.attr("string")
