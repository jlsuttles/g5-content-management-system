module LocationsHelper

  def page_disable_toggle(location, page)
    text = page.disabled? ? "Enable" : "Disable"
    dom_id = "disable-#{page.id}"
    link_to text, disable_location_page_path(@location, page, dom_id: dom_id), class: "btn btn-large", id: dom_id, method: :put, remote: true
  end

end