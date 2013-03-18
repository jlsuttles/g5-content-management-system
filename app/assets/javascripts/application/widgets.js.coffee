# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  # Adds jQuery-ui sortable functionality to all of the widget containers
  $('#choose-widgets, .add-widgets').sortable {
    connectWith: ".sortable",
    forcePlaceholderSize: true,
    cancel: ".section",
  }
  # Event when a widget container receives a widget
  $('.add-widgets').on "sortreceive", (event, ui) ->
    # Temporarily disables sorting
    $('.sortable').sortable('disable')
    $('.add-widgets li').each (index) ->
      # Changes the position value to it's order in the section
      $(this).find('.position').val(index + 1)
      # Changes the section value to match the section the widget was dropped in
      $(this).find('.section').val($(this).parent().data('section'))
    
    # Async update the pages widgets
    $.ajax {
      url: $('.edit_page').prop('action'),
      type: 'PUT',
      dataType: 'json',
      data: ui.item.find(":input").serialize(),
      success: (data) => 
        # Update the item with the db ID
        ui.item.data('id', data["id"])
        ui.item.find('.resource-id').val(data["id"])
        # Create a widget object out of the dropped widget
        widget = new Widget(ui.item)
        # Open the configuration form
        widget.openEditForm()
        # Re-enable sorting
        $('.sortable').sortable('enable')
      # TODO: Error Handling
      error: (xhr) => console.log("Error")
    }
  
  # Create widget objects out of all widgets on the page
  $('.widget').each ->
    new Widget(this)

# This is a class to handle the actions of widget objects.
class Widget
  constructor: (@element) ->
    $(@element).click =>
      this.openEditForm()
      false
  
  # open the configuration form retreived from the edit.html in the widget garden
  openEditForm: =>
    callback = (response) => this.openLightBox response
    $.get this.editURL(), {}, callback, "json"
    
  #  Submits the widget configuration to the widget controller
  saveEditForm: =>
    $.ajax {
      url: $('.modal-body .edit_widget').prop('action'),
      type: 'PUT',
      dataType: 'json',
      data: $('.modal-body .edit_widget').serialize(),
      # Hide the configuration form if the request is successful
      success: => $('#modal').modal('hide')
      error: (xhr) => 
        # This is/was needed because of a bug in jQuery, it's actually successful
        if xhr.status == 204
          $('#modal').modal('hide')
        # Add validation errors
        else if xhr.responseText.length
          this.insertErrorMessages($.parseJSON(xhr.responseText))
        # Add server errors
        else
          this.insertErrorMessages({errors: {base: ["There was a problem saving the widget"]}})
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
    