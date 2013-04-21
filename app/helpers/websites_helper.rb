module WebsitesHelper
  def web_template_disable_toggle(website, web_template)
    content_tag :div,
      content_tag(:input, {
        type: "checkbox",
        data: { remote_url: send("toggle_disabled_website_#{web_template.type.underscore}_path", website, web_template) },
        checked: !web_template.disabled?
      }),
      class: "switch switch-large",
      data: { on: "success", off: "danger" }
  end
end
