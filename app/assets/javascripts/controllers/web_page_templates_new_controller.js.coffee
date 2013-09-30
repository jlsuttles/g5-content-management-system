App.WebPageTemplatesNewController = Ember.ObjectController.extend
  actions:
    save: ->
      @get('model').save()

    cancel: ->
      @get('model').transaction.rollback()
      @transitionTo 'website'