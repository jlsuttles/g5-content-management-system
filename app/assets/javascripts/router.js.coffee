App.Router.map ->
  @resource "locations", path: "/"

  @resource "website", path: "/website/:website_id", ->
    @resource "webPageTemplates", ->
      @route "new"

  @resource "location", path: "/location/:location_id", ->
    @resource "webHomeTemplate", path: "/home/:web_home_template_id"
    @resource "webPageTemplate", path: "/page/:web_page_template_id"


  # @resource "locations", path: "/" ->
  #   @resource "location", path: "location", ->
  #      @route "edit", path: "/:location_id"

  #      @resource "webHomeTemplate", path: ":location_id/home", ->
  #        @route "edit", path: "/:web_home_template_id"

  #      @resource "web_page_template_id", path: ":location_id/page", ->
  #        @route "edit", path: "/:web_page_template_id"
