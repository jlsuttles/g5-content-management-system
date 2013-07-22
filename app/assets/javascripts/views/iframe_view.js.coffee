G5ClientHub.iFrameView = Ember.View.extend
  tagName: 'iframe'
  attributeBindings: ['src']

  didInsertElement: ->
    rootUrl = '/websites/'
    homeTemplateUrl = '/web_home_templates/'
    websiteUrn = @get('controller.websiteUrn')
    webHomeTemplateId = @get('controller.webHomeTemplateId')

    url = rootUrl + websiteUrn + homeTemplateUrl + webHomeTemplateId
    @set('src', url)
