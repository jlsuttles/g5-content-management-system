fixture.preload("fixtures.json")

module "Root Integration Tests",
  setup: ->
    fixtures = fixture.load("fixtures.json")[0]
    console.log fixtures["client"]
    # App.Client.FIXTURES = [fixtures["client"]]
    App.Location.FIXTURES = fixtures["locations"]
    App.Website.FIXTURES = fixtures["websites"]
    App.WebsiteTemplate.FIXTURES = fixtures["website_templates"]
    App.WebPageTemplate.FIXTURES = fixtures["web_page_templates"]
    App.WebHomeTemplate.FIXTURES = fixtures["web_home_templates"]
    App.MainWidget.FIXTURES = fixtures["main_widgets"]
    App.reset()

test "Page title", ->
  expect 1
  visit("/").then ->
    equal find(".page-title").length, 1, "one .page-title is displayed"

test "Location", ->
  expect 1
  visit("/").then ->
    equal find(".faux-table-row").length, 2, "two .faux-table-row are displayed"
