describe "Location", ->

  beforeEach ->
    Ember.testing = true

  describe "attributes", ->
      Em.run =>
        @location = App.Location.createRecord(id: 1)

    it "has a urn", ->
      expect(@location.get("urn")).toEqual("")
