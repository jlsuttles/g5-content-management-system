#
# vendor/assets
#
#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require bootstrap
#= require spectrum
#= require bootstrapSwitch
#= require jquery.thumbnailScroller
#= require ckeditor/init
#
# app/assets
#
#= require_tree ./application
#
# ember app
#
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require g5_client_hub
window.G5ClientHub = Ember.Application.create(LOG_TRANSITIONS: true)

$ ->
  $('input[type=color]').spectrum {
    preferredFormat: "hex",
    showInput: true
  }

  $('.layout-picker input, .theme-picker input').click ->
    $(this).parent().css('opacity', '1').siblings().css('opacity', '0.7')

  window.onload = ->
    $(".theme-picker .jThumbnailScroller").thumbnailScroller
      scrollerType:"clickButtons"
  		scrollerOrientation:"horizontal"
  		scrollSpeed:2
  		scrollEasing:"easeOutCirc"
  		scrollEasingAmount:600
  		acceleration:4
  		scrollSpeed:800
  		noScrollCenterSpace:10
  		autoScrolling:0
  		autoScrollingSpeed:2000
  		autoScrollingEasing:"easeInOutQuad"
  		autoScrollingDelay:500
