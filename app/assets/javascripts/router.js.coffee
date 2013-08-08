App.Router.map ->
  @resource "websites", path: "/websites/:website_urn"
  @resource "location", path: "/location/:location_id", ->
    @resource "webHomeTemplate", path: "/home/:web_home_template_id"
    @resource "webPageTemplate", path: "/page/:web_page_template_id"
