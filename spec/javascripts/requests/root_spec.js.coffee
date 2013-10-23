module "Root Integration Tests",
  setup: ->
    App.reset()

test "Page title", ->
  expect 1
  visit("/").then ->
    equal find(".page-title").length, 1, "one .page-title is displayed"

test "Location", ->
  expect 1
  visit("/").then ->
    console.log find(".faux-table-row").length
    ok find(".faux-table-row").length, "at least one .faux-table-row is displayed"
