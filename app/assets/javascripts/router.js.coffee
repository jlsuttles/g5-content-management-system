App.Router.map ->
  @resource "locations", path: "/"

  @resource "website", path: "/:website_slug", ->
    @resource "webPageTemplates", ->
      @route "new"

  @resource "location", path: "/location/:location_id", ->
    @resource "webHomeTemplate", path: "/home/:web_home_template_id"
    @resource "webPageTemplate", path: "/page/:web_page_template_id"

App.Router.reopen
  location: 'history'
