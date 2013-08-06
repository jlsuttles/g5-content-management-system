G5ClientHub::ClientReader.perform(ENV["G5_CLIENT_UID"] || "spec/support/client.html")

def create_website_template(website, website_template_defaults)
  website_template = website.create_website_template(web_template_params(website_template_defaults))
  web_layout = website_template.create_web_layout(layout_params(website_template_defaults["web_layout"]))
  web_theme = website_template.create_web_theme(theme_params(website_template_defaults["web_theme"]))
  create_drop_targets(website_template, website_template_defaults["drop_targets"])
end

def create_web_home_template(website, web_home_template_defaults)
  web_home_template = website.create_web_home_template(web_template_params(web_home_template_defaults))
  create_drop_targets(web_home_template, web_home_template_defaults["drop_targets"])
end

def create_web_page_templates(website, web_page_templates_defaults)
  web_page_templates_defaults.each do |web_page_template_defaults|
    web_page_template = website.web_page_templates.create(web_template_params(web_page_template_defaults))
    create_drop_targets(web_page_template, web_page_template_defaults["drop_targets"])
  end
end

def create_drop_targets(web_template, drop_targets_defaults)
  drop_targets_defaults.each do |drop_target_defaults|
    drop_target = web_template.drop_targets.create(drop_target_params(drop_target_defaults))
    create_widgets(drop_target, drop_target_defaults["widgets"])
  end
end

def create_widgets(drop_target, widgets_defaults)
  widgets_defaults.each do |widget_defaults|
    drop_target.widgets.create(widget_params(widget_defaults))
  end
end

def web_template_params(web_template_defaults)
  ActionController::Parameters.new(web_template_defaults).permit(:name)
end

def layout_params(layout_defaults)
  layout_defaults["url"] = WebLayout.component_url(layout_defaults["name"])
  ActionController::Parameters.new(layout_defaults).permit(:url)
end

def theme_params(theme_defaults)
  theme_defaults["url"] = WebTheme.component_url(theme_defaults["name"])
  ActionController::Parameters.new(theme_defaults).permit(:url)
end

def drop_target_params(drop_target_defaults)
  ActionController::Parameters.new(drop_target_defaults).permit(:html_id)
end

def widget_params(widget_defaults)
  widget_defaults["url"] = Widget.component_url(widget_defaults["name"])
  ActionController::Parameters.new(widget_defaults).permit(:url)
end

Location.all.each do |location|
  puts "creating website for location #{location.name}"
  website = location.create_website
  puts "creating website template"
  create_website_template(website, DEFAULTS["website"]["website_template"])
  puts "creating web home template"
  create_web_home_template(website, DEFAULTS["website"]["web_home_template"])
  puts "creating web page template"
  create_web_page_templates(website, DEFAULTS["website"]["web_page_templates"])
end
