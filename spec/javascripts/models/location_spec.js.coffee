describe "Location", ->

  beforeEach ->
    App.reset()

  describe "attributes", ->

    beforeEach ->
      Ember.run =>
        @location = App.Location.createRecord(id: 1, urn: "test")

    afterEach ->
      Ember.run =>
        @location.destroy()

    it "has a urn", ->
      expect(@location.get("urn")).toEqual("test")
