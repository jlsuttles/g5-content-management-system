#
# vendor/assets
#
#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require bootstrap
#= require spectrum
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
