App.WebPageTemplatesNewController = Ember.ObjectController.extend
  actions:
    save: ->
      @get('model').save()
      @transitionTo 'website'

    cancel: ->
      @get('model').deleteRecord()
      @transitionTo 'website'