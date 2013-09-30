App.Router.map ->
  @resource "website", path: "/website/:website_id", ->
    @resource "webPageTemplates", ->
      @route "new"
  @resource "location", path: "/location/:location_id", ->
    @resource "webHomeTemplate", path: "/home/:web_home_template_id"
    @resource "webPageTemplate", path: "/page/:web_page_template_id"
