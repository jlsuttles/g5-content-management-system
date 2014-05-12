class Website < ActiveRecord::Base
  include HasManySettings
  include HasSettingNavigation
  include AfterCreateUpdateUrn
  include ToParamUrn

  COMPILE_PATH = File.join(Rails.root, "tmp","static_sites")

  set_urn_prefix "g5-clw"

  belongs_to :owner, polymorphic: true

  has_one  :website_template, dependent: :destroy
  has_one  :web_home_template, dependent: :destroy
  has_many :web_page_templates, -> { order("web_templates.display_order ASC") }, dependent: :destroy
  has_many :web_templates
  has_many :assets, dependent: :destroy
  has_many :widgets, through: :web_templates
  has_many :widget_settings, through: :widgets, source: :settings

  validates :urn, presence: true, uniqueness: true, unless: :new_record?

  scope :location_websites, -> { where(owner_type: "Location") }

  def website_id
    id
  end

  def name
    owner.try(:name)
  end

  def slug
    name.try(:parameterize)
  end

  def compile_path
    if single_domain_location?
      File.join(COMPILE_PATH, client.website.urn, urn)
    else
      File.join(COMPILE_PATH, urn)
    end
  end

  def stylesheets
    web_templates.map(&:stylesheets).flatten.uniq
  end

  def javascripts
    web_templates.map(&:javascripts).flatten.uniq
  end

  def deploy
    StaticWebsiteDeployerJob.perform(urn)
  end

  def async_deploy
    Resque.enqueue(StaticWebsiteDeployerJob, urn)
  end

  def colors
    website_template.try(:colors)
  end

  def stylesheets_compiler
    @stylesheets_compiler ||=
      StaticWebsite::Compiler::Stylesheets.new(stylesheets,
      "#{Rails.root}/public", colors, name)
  end

  def application_min_css_path
    if single_domain_location?
      "/#{urn}/stylesheets/application.min.css"
    else
      stylesheets_compiler.uploaded_path
    end
  end

private

  def single_domain_location?
    client.type == "SingleDomainClient" && owner_type == "Location"
  end

  def client
    @client ||= Client.first
  end
end
