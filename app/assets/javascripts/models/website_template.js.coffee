G5ClientHub.WebsiteTemplate = DS.Model.extend
  location: DS.belongsTo("G5ClientHub.Location"),
  website: DS.belongsTo("G5ClientHub.Website"),

  webLayout: DS.belongsTo("G5ClientHub.WebLayout"),
  webTheme: DS.belongsTo("G5ClientHub.WebTheme"),

  logoWidgets: DS.hasMany("G5ClientHub.LogoWidget"),
  phoneWidgets: DS.hasMany("G5ClientHub.PhoneWidget"),
  btnWidgets: DS.hasMany("G5ClientHub.BtnWidget"),
  navWidgets: DS.hasMany("G5ClientHub.NavWidget"),
  asideWidgets: DS.hasMany("G5ClientHub.AsideWidget"),
  footerWidgets: DS.hasMany("G5ClientHub.FooterWidget"),

  websiteUrn: DS.attr("string"),
  webHomeTemplateId: DS.attr("number")
