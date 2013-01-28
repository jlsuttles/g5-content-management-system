# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#choose-widgets, .add-widgets').sortable {
    connectWith: ".sortable",
    forcePlaceholderSize: true,
    cancel: ".section",
  }
  
  $('.add-widgets').on "sortreceive", (event, ui) ->
    $('.sortable').sortable('disable')
    $('.add-widgets li').each (index) ->
      $(this).find('.position').val(index + 1)
      $(this).find('.section').val($(this).parent().data('section'))
    
    $.ajax {
      url: $('.edit_page').prop('action'),
      type: 'PUT',
      dataType: 'json',
      data: ui.item.find(":input").serialize(),
      success: (data) => 
        ui.item.data('id', data["id"])
        ui.item.find('.resource-id').val(data["id"])
        widget = new Widget(ui.item)
        widget.openEditForm()
        $('.sortable').sortable('enable')
      error: (xhr) => console.log("Error")
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
    $.ajax {
      url: $('.modal-body .edit_widget').prop('action'),
      type: 'PUT',
      dataType: 'json',
      data: $('.modal-body .edit_widget').serialize(),
      success: => $('#modal').modal('hide')
      error: (xhr) => this.insertErrorMessages($.parseJSON(xhr.responseText))
    }

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
    false
    
  editURL: =>
    '/widgets/' + $(@element).data('id') + "/edit"
    