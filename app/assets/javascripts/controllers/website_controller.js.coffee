App.WebsiteController = Ember.ObjectController.extend
  actions:
    cancel: ->
      @get('transaction').rollback()

