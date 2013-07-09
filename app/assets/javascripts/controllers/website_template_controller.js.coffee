G5ClientHub.WebsiteTemplateController = Ember.ObjectController.extend
  needs: ["widgets"]

  removeWidget: (widget) ->
    widget.deleteRecord()
    widget.save()
