G5ClientHub.RemoteWidget = DS.Model.extend
  name: DS.attr("string"),
  thumbnail: DS.attr("string"),
  url: DS.attr("string"),
  isAddedToLogoWidgets: null,
  isAddedToPhoneWidgets: null,
  isAddedToBtnWidgets: null,
  isAddedToNavWidgets: null,
  isAddedToAsideWidgets: null,
  isAddedToFooterWidgets: null
