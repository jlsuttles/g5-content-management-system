G5ClientHub.RemoteWidgetsController = Ember.ArrayController.extend
  needs: [
    "logoWidgets",
    "phoneWidgets",
    "btnWidgets",
    "navWidgets",
    "asideWidgets",
    "footerWidgets"
  ]

  currentDragItem: ( ->
    console.log "currentDragItem"
    @findProperty "isDragging", true
  ).property("@each.isDragging")

  logoWidgets: ( ->
    @get("controllers.logoWidgets.model")
  ).property("controllers.logoWidgets.model")

  phoneWidgets: ( ->
    @get("controllers.phoneWidgets.model")
  ).property("controllers.phoneWidgets.model")

  btnWidgets: ( ->
    @get("controllers.btnWidgets.model")
  ).property("controllers.btnWidgets.model")

  navWidgets: ( ->
    @get("controllers.navWidgets.model")
  ).property("controllers.navWidgets.model")

  asideWidgets: ( ->
    @get("controllers.asideWidgets.model")
  ).property("controllers.asideWidgets.model")

  footerWidgets: ( ->
    @get("controllers.footerWidgets.model")
  ).property("controllers.footerWidgets.model")
