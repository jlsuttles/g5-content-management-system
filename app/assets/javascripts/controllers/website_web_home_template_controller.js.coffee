App.WebsiteWebHomeTemplateController = Ember.ObjectController.extend
  actions:
    save: (model) ->
      model.save()
      @transitionToRoute 'website'

    cancel: (model) ->
      model.get('transaction').rollback()
      @transitionToRoute 'website'
