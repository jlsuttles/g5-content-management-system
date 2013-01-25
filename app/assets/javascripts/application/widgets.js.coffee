# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#choose-widgets, #add-widgets').sortable {
    connectWith: ".sortable",
    forcePlaceholderSize: true,
    cancel: ".section",
    stop: (event, ui)->
      $('#add-widgets li').each (index) ->
        $(this).find('.position').val(index + 1)
        $(this).find('.section').val($(this).parent().data('section'))
  }
  
  $('.widget').each ->
    new Widget(this)

class Widget
  constructor: (@element) ->
    $(@element).click =>
      this.openEditForm()
      false
  
  openEditForm: =>
    callback = (response) => this.openLightBox response
    $.get this.editURL(), {}, callback, "json"
    
  saveEditForm: =>
    console.log "save"
    $.ajax {
      url: $('.modal-body .edit_widget').prop('action'),
      type: 'PUT',
      dataType: 'json',
      data: $('.modal-body .edit_widget').serialize(),
      success: => $('#modal').modal('hide')
      error: (xhr) => this.insertErrorMessages($.parseJSON(xhr.responseText))
    }
    false

  insertErrorMessages: (errors) =>
    error = "<div class=\"alert alert-error\">" + 
      errors["errors"]["base"][0] + 
      "</div>"
    $('#modal .modal-body').prepend error
      
  openLightBox: (response) ->
    $('#modal .modal-body').html(response["html"])
    $('#modal').modal()
    $('.modal-body .edit_widget').submit => 
      this.saveEditForm()
      false
    
  editURL: =>
    '/widgets/' + $(@element).data('id') + "/edit"
    