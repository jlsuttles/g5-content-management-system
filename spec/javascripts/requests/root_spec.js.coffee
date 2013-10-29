fixture.preload("fixtures.json")

module "Root Integration Tests",
  setup: ->
    App.Location.FIXTURES = fixture.load("fixtures.json")[0]
    App.reset()

test "Page title", ->
  expect 1
  visit("/").then ->
    equal find(".page-title").length, 1, "one .page-title is displayed"

test "Location", ->
  expect 1
  visit("/").then ->
    equal find(".faux-table-row").length, 2, "two .faux-table-row are displayed"
