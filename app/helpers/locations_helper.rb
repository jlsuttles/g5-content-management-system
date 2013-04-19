module LocationsHelper

  def page_disable_toggle(location, page)
    text = page.disabled? ? "Enable" : "Disable"
    dom_id = "page-disabled-#{page.id}"
    css_class = "btn btn-large "
    css_class << (page.disabled? ? "page-disabled" : "page-enabled")
    link_to text, toggle_disabled_location_page_path(@location, page, dom_id: dom_id), class: css_class, id: dom_id, method: :put, remote: true
  end

end