$ ->
  $('body[class~=staging] form').each ->
    new FormSubmitDisabler $(this)
  $('body[class~=development] form').each ->
    new FormSubmitDisabler $(this)
  $('body[class~=test] form').each ->
    new FormSubmitDisabler $(this)

class FormSubmitDisabler
  constructor:($element) ->
    $submitInput = $element.find('input[type=submit]')
    $submitInput.attr('disabled', 'disabled')
