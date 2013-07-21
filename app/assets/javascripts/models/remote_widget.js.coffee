G5ClientHub.RemoteWidget = DS.Model.extend
  name: DS.attr("string"),
  thumbnail: DS.attr("string"),
  url: DS.attr("string"),
  isAddedToLogoWidgetsDropTarget: null,
  isAddedToPhoneWidgetsDropTarget: null,
  isAddedToBtnWidgetsDropTarget: null,
  isAddedToNavWidgetsDropTarget: null,
  isAddedToAsideWidgetsDropTarget: null,
  isAddedToFooterWidgetsDropTarget: null
