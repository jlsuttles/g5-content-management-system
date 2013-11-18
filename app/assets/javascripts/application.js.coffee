#= require jquery
#= require jquery.ui.all
#= require jquery_ujs
#= require bootstrap
#= require spectrum
#= require bootstrapSwitch
#= require jquery.thumbnailScroller
#= require ckeditor/init

$ ->

  $('.layout-picker input, .theme-picker input').click ->
    $(this).parent().css('opacity', '1').siblings().css('opacity', '0.7')

  $(".card-flip").on "click", (e) ->
    $(this).parents(".flip-container").toggleClass "flipped"
    e.preventDefault()

  window.setTimeout (->
    $(".alert").css "opacity", 0
  ), 3000

  window.setTimeout (->
    $(".alert").remove()
  ), 3500

  window.onload = ->

    $('input.color').spectrum {
      preferredFormat: "hex",
      showInput: true
    }
