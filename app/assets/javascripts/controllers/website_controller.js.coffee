App.WebsiteController = Ember.ObjectController.extend
  actions:
    save: (webPageTemplate) ->
      webPageTemplate.save()
      @transitionToRoute 'website'

    cancel: (webPageTemplate) ->
      webPageTemplate.get('transaction').rollback()
      @transitionToRoute 'website'

    deploy: (model) ->
      url = "/websites/" + model.id + "/deploy"
      $("<form action='" + url + "' method='post'></form>").submit()
      false
