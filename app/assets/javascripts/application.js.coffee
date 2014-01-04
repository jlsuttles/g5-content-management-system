#= require jquery
#= require jquery.ui.all
#= require jquery_ujs
#= require bootstrap
#= require spectrum
#= require bootstrapSwitch
#= require jquery.thumbnailScroller
#= require ckeditor/init

$ ->
  # add the dataTransfer property for use with the native `drop` event
  # to capture information about files dropped into the browser window
  $.event.props.push("dataTransfer")

  #= Allows CKEditor modal to play nice with Bootstrap modal
  $.fn.modal.Constructor::enforceFocus = ->
    modalThis = this

    $(document).on "focusin.modal", (e) ->

      element = modalThis.$element
      target = e.target

      shouldFocus = (element, target) ->

        elementIsNotTarget = ->
          element[0] isnt target

        elementHasNoTarget = ->
          not element.has(target).length

        parentIsNotSelect = ->
          not $(target.parentNode).hasClass("cke_dialog_ui_input_select")

        parentIsText = ->
          $(target.parentNode).hasClass("cke_dialog_ui_input_text")

        elementIsNotTarget and elementHasNoTarget and parentIsNotSelect and not parentIsText

      element.focus()  if shouldFocus(element, target)


  $('.layout-picker input, .theme-picker input').click ->
    $(this).parent().css('opacity', '1').siblings().css('opacity', '0.7')

  $(".card-flip").on "click", (e) ->
    $(this).parents(".flip-container").toggleClass "flipped"
    e.preventDefault()

  window.setTimeout (->
    $(".alert").slideUp()
  ), 3000

  window.setTimeout (->
    $(".alert").remove()
  ), 3500

  window.onload = ->

    $('input.color').spectrum {
      preferredFormat: "hex",
      showInput: true
    }
