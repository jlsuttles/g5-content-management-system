# VENDOR
#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require bootstrap
#= require spectrum

# APPLICATION
#= require_self

$ ->
  $('#choose-widgets, #add-widgets').sortable {
    connectWith: ".sortable",
    cancel: ".section"
    stop: (event, ui)->
      $('#add-widgets li').each (index) ->
        $(this).find('.position').val(index + 1)
        $(this).find('.section').val($(this).parent().data('section'))
  }
  $('input[type=color]').spectrum {
    preferredFormat: "hex",
    showInput: true
  }
