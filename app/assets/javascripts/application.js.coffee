#= require jquery
#= require jquery.ui.all
#= require jquery_ujs
#= require bootstrap
#= require spectrum
#= require bootstrapSwitch
#= require jquery.thumbnailScroller
#= require ckeditor/init

$ ->
  
  $.fn.modal.Constructor::enforceFocus = ->
    modal_this = this
    $(document).on "focusin.modal", (e) ->
      modal_this.$element.focus()  if modal_this.$element[0] isnt e.target and not modal_this.$element.has(e.target).length and not $(e.target.parentNode).hasClass("cke_dialog_ui_input_select") and not $(e.target.parentNode).hasClass("cke_dialog_ui_input_text")
  

  $('.layout-picker input, .theme-picker input').click ->
    $(this).parent().css('opacity', '1').siblings().css('opacity', '0.7')

  $(".card-flip").on "click", (e) ->
    $(this).parents(".flip-container").toggleClass "flipped"
    e.preventDefault()

  window.setTimeout (->
    $(".alert").addClass 'hide-alert'
  ), 3000

  window.setTimeout (->
    $(".alert").remove()
  ), 3500

  window.onload = ->

    $('input.color').spectrum {
      preferredFormat: "hex",
      showInput: true
    }
