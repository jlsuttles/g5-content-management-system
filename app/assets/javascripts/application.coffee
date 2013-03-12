#
# vendor/assets
#
#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require bootstrap
#= require spectrum
#= require jquery.thumbnailScroller
#
# app/assets
#
#= require_self
#= require_tree ./application

$ ->
  $('input[type=color]').spectrum {
    preferredFormat: "hex",
    showInput: true
  }

  window.onload = ->
    $("#chad").thumbnailScroller
      scrollerType:"hoverAccelerate"
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