module LocationsHelper

  def page_disable_toggle(location, page)
    content_tag :div, {:class => "switch switch-large", :data => {on: "success", off: "danger"}} do
      "<input type=\"checkbox\" data-remote-url=\"#{toggle_disabled_location_page_path(location, page)}\"#{" checked" unless page.disabled?} />".html_safe
    end
  end

end