class WebsiteSeeder
  attr_reader :location, :instructions, :website

  def initialize(location, instructions=DEFAULTS["website"])
    @location = location
    @instructions = instructions
  end

  def seed
    client = Client.first

    Rails.logger.info "Creating website for location #{location.name}"
    @website = location.create_website

    Rails.logger.info "Creating website settings"
    website.settings.create!(name: "client_urn", value: client.urn)
    website.settings.create!(name: "location_urn", value: location.urn)
    website.settings.create!(name: "location_street_address", value: location.street_address)
    website.settings.create!(name: "location_city", value: location.city)
    website.settings.create!(name: "location_state", value: location.state)
    website.settings.create!(name: "location_postal_code", value: location.postal_code)
    website.settings.create!(name: "phone_number", value: location.phone_number)

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
