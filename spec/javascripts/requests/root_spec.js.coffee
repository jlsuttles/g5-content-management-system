describe "Root", ->

  beforeEach ->
    App.reset()

  describe "when location exists", ->

    beforeEach ->
      Ember.run =>
        @location = App.Location.createRecord(id: 1, name: "test")

    afterEach ->
      Ember.run =>
        @location.destroy()

    it "has location name", ->
      visit("/ember").then ->
        expect(find(".location")).toBe(true)
