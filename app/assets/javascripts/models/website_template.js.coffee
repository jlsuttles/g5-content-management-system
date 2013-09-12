App.WebsiteTemplate = DS.Model.extend
  website: DS.belongsTo("App.Website")
  webLayout: DS.belongsTo("App.WebLayout")
  webTheme: DS.belongsTo("App.WebTheme")
  headWidgets: DS.hasMany("App.HeadWidget")
  logoWidgets: DS.hasMany("App.LogoWidget")
  phoneWidgets: DS.hasMany("App.PhoneWidget")
  btnWidgets: DS.hasMany("App.BtnWidget")
  navWidgets: DS.hasMany("App.NavWidget")
  asideWidgets: DS.hasMany("App.AsideWidget")
  footerWidgets: DS.hasMany("App.FooterWidget")
