App.Router.map ->
  @resource "location", path: "/:location_slug", ->
    @resource "webHomeTemplate", path: "/:web_home_template_slug"
    @resource "webPageTemplate", path: "/:web_page_template_slug"

  @resource "website", path: "/:website_slug", ->
    @resource "webPageTemplates", ->
      @route "new"

  @resource "locations", path: "/"

App.Router.reopen
  location: "history"
