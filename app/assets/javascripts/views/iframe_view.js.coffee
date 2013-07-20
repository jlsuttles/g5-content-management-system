G5ClientHub.iFrameView = Ember.View.extend
  tagName: 'iframe'
  attributeBindings: ['src', 'style']
  src: ( ->
    rootUrl = '/websites/'
    homeTemplateUrl = '/web_home_templates/'
    websiteUrn = @get('controller.websiteUrn')
    webHomeTemplateId = @get('controller.webHomeTemplateId')

    rootUrl + websiteUrn + homeTemplateUrl + webHomeTemplateId
  ).property('controller.model')
