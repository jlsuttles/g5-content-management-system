class WebLayout < ActiveRecord::Base
  include ComponentGardenable
  include HasManySettings

  set_garden_url ENV["LAYOUT_GARDEN_URL"]

  belongs_to :garden_web_layout
  belongs_to :web_template
  has_one :website, through: :web_template

  def website_id
    web_template.website_id if web_template
  end

  def website_template
    web_template
  end

  def website_template_id
    web_template_id
  end
end
