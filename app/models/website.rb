class Website < ActiveRecord::Base
  include HasManySettings
  include HasSettingNavigation
  include HasSettingAvailableCallsToAction
  include AfterCreateSetSettingAvailableCallsToAction
  include AfterCreateUpdateUrn
  include ToParamUrn
  include DefaultWebPageTemplates

  COMPILE_PATH = File.join(Rails.root, "tmp", "compiled_sites")

  set_urn_prefix "g5-clw"

  attr_accessible :urn,
                  :custom_colors,
                  :primary_color,
                  :secondary_color

  belongs_to :location

  has_many :web_templates
  # subclasses of web_templates
  has_one  :website_template, autosave: true, dependent: :destroy
  has_one  :web_home_template, autosave: true, dependent: :destroy
  has_many :web_page_templates, autosave: true, dependent: :destroy

  has_many :widgets, through: :web_templates

  validates :urn, presence: true, uniqueness: true, unless: :new_record?

  before_create :build_website_template
  before_create :build_web_home_template

  def name
    location.try(:name)
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
    WebsiteDeployer.perform(urn)
  end

  def async_deploy
    Resque.enqueue(WebsiteDeployer, urn)
  end

  def primary_color
    if custom_colors?
      read_attribute(:primary_color)
    else
      website_template.try(:primary_color) || "#000000"
    end
  end

  def secondary_color
    if custom_colors?
      read_attribute(:secondary_color)
    else
      website_template.try(:secondary_color) || "#ffffff"
    end
  end
end
