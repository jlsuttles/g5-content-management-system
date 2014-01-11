App.WidgetController = Ember.ObjectController.extend
  deleteWidget: ->
    @get("content").deleteRecord()
    @get("content").save()
