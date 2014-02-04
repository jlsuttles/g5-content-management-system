class WebsiteSeeder
  attr_reader :location, :instructions, :website

  def initialize(location, instructions=DEFAULTS["website"])
    @location = location
    @instructions = instructions
  end

  def seed
    client_services = ClientServices.new
    client = client_services.client

    Rails.logger.info "Creating website for location #{location.name}"
    @website = location.create_website

    Rails.logger.info "Creating website settings"
    create_setting!("client_urn", client_services.client_urn)
    create_setting!("client_url", client_services.client_url)
    create_setting!("client_location_urns", client_services.client_location_urns)
    create_setting!("client_location_urls", client_services.client_location_urls)

    ClientServices::SERVICES.each do |service|
      %w(urn url).each do |suffix|
        setting_name = [service, suffix].join("_")
        create_setting!(setting_name, client_services.public_send(setting_name.to_sym))
      end
    end

    create_setting!("location_urn", location.urn)
    create_setting!("location_url", location.domain)
    create_setting!("location_street_address", location.street_address)
    create_setting!("location_city", location.city)
    create_setting!("location_state", location.state)
    create_setting!("location_postal_code", location.postal_code)
    create_setting!("phone_number", location.phone_number)

    Rails.logger.info "Creating website template"
    create_website_template(website, instructions["website_template"])

    Rails.logger.info "Creating web home template"
    create_web_home_template(website, instructions["web_home_template"])

    Rails.logger.info "Creating web page template"
    create_web_page_templates(website, instructions["web_page_templates"])

    website
  end

  def create_website_template(website, instruction)
    if website && instruction
      website_template = website.create_website_template(web_template_params(instruction))
      web_layout = website_template.create_web_layout(layout_params(instruction["web_layout"]))
      web_theme = website_template.create_web_theme(theme_params(instruction["web_theme"]))
      create_drop_targets(website_template, instruction["drop_targets"])
    end
  end

  def create_web_home_template(website, instruction)
    if website && instruction
      web_home_template = website.create_web_home_template(web_template_params(instruction))
      create_drop_targets(web_home_template, instruction["drop_targets"])
    end
  end

  def create_web_page_templates(website, instructions)
    if website && instructions
      instructions.each do |instruction|
        web_page_template = website.web_page_templates.create(web_template_params(instruction))
        create_drop_targets(web_page_template, instruction["drop_targets"])
      end
    end
  end

  def create_drop_targets(web_template, instructions)
    if web_template && instructions
      instructions.each do |instruction|
        drop_target = web_template.drop_targets.create(drop_target_params(instruction))
        create_widgets(drop_target, instruction["widgets"])
      end
    end
  end

  def create_widgets(drop_target, instructions)
    if drop_target && instructions
      instructions.each do |instruction|
        drop_target.widgets.create(widget_params(instruction))
      end
    end
  end

  private

  def create_setting!(name, value)
    website.settings.find_or_create_by_name!(name: name, value: value)
  end

  def web_template_params(instructions)
    ActionController::Parameters.new(instructions).permit(:name)
  end

  def layout_params(instructions)
    instructions["url"] = WebLayout.component_url(instructions["name"])
    ActionController::Parameters.new(instructions).permit(:url)
  end

  def theme_params(instructions)
    instructions["url"] = WebTheme.component_url(instructions["name"])
    ActionController::Parameters.new(instructions).permit(:url)
  end

  def drop_target_params(instructions)
    ActionController::Parameters.new(instructions).permit(:html_id)
  end

  def widget_params(instructions)
    instructions["url"] = Widget.component_url(instructions["name"])
    ActionController::Parameters.new(instructions).permit(:url)
  end
end
