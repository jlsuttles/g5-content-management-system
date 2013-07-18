G5ClientHub.iFrameView = Ember.View.extend
  tagName: 'iframe',
  attributeBindings: ['src', 'style'],
  style: 'width: 100%; height: 500px;',
  src: ->
    return '/websites/g5-clw-4-north-shore-oahu/web_home_templates/34'