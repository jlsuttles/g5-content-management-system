# VENDOR
#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require bootstrap
# APPLICATION
#= require_self
#= require_tree .

$ ->
  $('#choose-widgets, #add-widgets').sortable {
    connectWith: ".sortable",
    cancel: ".section"
    stop: (event, ui)->
      $('#add-widgets li').each (index) ->
        $(this).find('.position').val(index + 1)
        $(this).find('.section').val($(this).parent().data('section'))
  }
  