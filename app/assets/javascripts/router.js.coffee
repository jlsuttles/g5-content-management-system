G5ClientHub.Router.map ->
  @resource "website_template",
    path: "/website_template/:website_template_id"
  , ->
    @route "edit"
    @resource "web_layout", ->
      @route "edit"
  @resource "web_layouts"
