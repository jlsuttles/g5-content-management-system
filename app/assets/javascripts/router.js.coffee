App.Router.map ->
  @resource "webHomeTemplate", path: "/:website_slug/:web_home_template_slug"
  @resource "webPageTemplate", path: "/:website_slug/:web_page_template_slug"

  @resource "website", path: "/:website_slug", ->
    @resource "webPageTemplates", ->
      @route "new"

  @resource "locations", path: "/"

App.Router.reopen
  location: "history"
