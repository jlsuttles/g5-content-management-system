G5ClientHub.iFrameView = Ember.View.extend
  tagName: 'iframe'
  attributeBindings: ['src', 'style']

  # Temporary for testing
  style: 'width: 100%; height: 500px;'

  src: ( ->
    rootUrl = '/websites/'
    homeTemplateUrl = '/web_home_templates/'
    locationId = @get('controller.model.location.id')
    locationUrn = G5ClientHub.Location.find(locationId).get('urn')

    #This needs to be the ID of the page, not the template
    websiteTemplateId = @get('controller.model.id')

    # constructs preview url
    url = rootUrl + locationUrn + homeTemplateUrl + websiteTemplateId
  ).property('controller.model.location.urn')
