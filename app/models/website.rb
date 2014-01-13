class Website < ActiveRecord::Base
  include HasManySettings
  include HasSettingNavigation
  include AfterCreateUpdateUrn
  include ToParamUrn

  COMPILE_PATH = File.join(Rails.root, "tmp","static_sites")

  set_urn_prefix "g5-clw"

  belongs_to :location

  has_one  :website_template, dependent: :destroy
  has_one  :web_home_template, dependent: :destroy
  has_many :web_page_templates, dependent: :destroy, order: "display_order ASC"
  has_many :web_templates
  has_many :widgets, through: :web_templates
  has_many :widget_settings, through: :widgets, source: :settings

  validates :urn, presence: true, uniqueness: true, unless: :new_record?

  def website_id
    id
  end

  def name
    location.try(:name)
  end

  def slug
    name.try(:parameterize)
  end

  def compile_path
    File.join(COMPILE_PATH, urn)
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
end
