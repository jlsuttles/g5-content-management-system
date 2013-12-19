App.RedirectManagerController = Ember.ObjectController.extend
  actions:
    save: (model) ->
      model.save()
