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
    stop: (event, ui)->
      $('#add-widgets li').each (index) ->
        console.log $(this).find('.position').val(index + 1)
  }
  
