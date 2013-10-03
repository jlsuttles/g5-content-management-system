App.WebsiteController = Ember.ObjectController.extend
  actions:
    save: (webPageTemplate) ->
      webPageTemplate.save()

    cancel: ->
      @get('transaction').rollback()
      @transitionTo('website')

