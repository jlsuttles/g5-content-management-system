G5ClientHub.WebTheme = DS.Model.extend
  webTemplate: DS.belongsTo("G5ClientHub.WebsiteTemplate")
  name: DS.attr("string")
  thumbnail: DS.attr("string")
  url: DS.attr("string")

  didUpdate: ->
    # Reloads iFrame preview
    url = $('iframe').prop('src')
    $('iframe').prop('src', url)
