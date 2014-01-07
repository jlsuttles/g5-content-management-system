#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require app

window.App = Ember.Application.create(LOG_TRANSITIONS: true)

# Put jQuery UI inside its own namespace
window.JQ = Ember.Namespace.create()
