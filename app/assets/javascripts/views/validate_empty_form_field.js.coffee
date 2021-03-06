App.ValidateEmptyFormField = Ember.View.extend
  classNames: ["form-field"]

  keyUp: (e) ->
    input = $(e.currentTarget).find("input")
    allInputs = $(e.currentTarget).parents("form").find("input[type=text]")
    saveBtn = $(e.currentTarget).parents("form").find(".save")

    updateCurrentInput = ->
      if input.val().trim().length is 0
        input.addClass("error")
        saveBtn.prop("disabled", true)
      else
        input.removeClass("error")
        validateForm()

    updateEmptyInputs = ->
      allInputs.each ->
        if $(this).val().trim().length is 0
          $(this).addClass("error")
      false

    validateForm = ->
      updateEmptyInputs()

      if allInputs.hasClass("error")
        false
      else
        saveBtn.prop("disabled", false)

    updateCurrentInput()
