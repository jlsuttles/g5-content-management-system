#= require application
#= require ember_app

# Unsure why we need this. We are not using AMD. But we need it.
Teaspoon.defer = true
setTimeout(Teaspoon.execute, 1000)

((window) ->
  # Register Ember Test helpers.
  testing = ->
    helper =
      exists: (selector) ->
        !!find(selector).length
    helper

  Ember.Test.registerHelper "exists", (selector) ->
    testing().exists(selector)

  # Move Ember App to an element on the page so it can be seen while testing.
  window.document.write('
    <div id="ember-testing-container">
      <div id="ember-testing"></div>
    </div>
    <style>
      #ember-testing-container {
        position: absolute;
        background: white;
        bottom: 0;
        right: 0;
        width: 640px;
        height: 384px;
        overflow: auto;
        z-index: 9999;
        border: 1px solid #ccc;
      }
      #ember-testing { zoom: 50%; }
    </style>
  ')
  App.rootElement = "#ember-testing"

  # Setup Ember App for testing.
  App.setupForTesting()
  App.injectTestHelpers()

  # Inject the store into all components.
  App.inject('component', 'store', 'store:main')
)(window)
