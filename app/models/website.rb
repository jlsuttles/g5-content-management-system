class Website < ActiveRecord::Base
  COMPILED_SITES_PATH = File.join(Rails.root, "tmp", "compiled_sites")
  attr_accessible :urn,
                  :custom_colors,
                  :primary_color,
                  :secondary_color

  belongs_to :location

  has_one :website_template, autosave: true, dependent: :destroy
  has_many :web_page_templates, autosave: true, dependent: :destroy

  has_many :web_templates
  has_many :widgets, through: :web_templates

  before_create :build_default_website_template
  before_create :build_default_web_page_template

  after_create :set_urn

  def location_name
    location ? location.name : ""
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

  def async_deploy
    Resque.enqueue(LocationDeployer, self.urn)
  end

  def deploy
    LocationDeployer.perform(self.urn)
  end

  def homepage
    web_page_templates.home.first
  end

  def stylesheets
    web_page_templates.map(&:stylesheets).flatten.uniq
  end

  def javascripts
    web_page_templates.map(&:javascripts).flatten.uniq
  end

  def github_repo
    "git@github.com:G5/static-heroku-app.git"
  end

  def heroku_app_name
    urn[0..29] if urn
  end

  def heroku_repo
    "git@heroku.com:#{heroku_app_name}.git"
  end

  def heroku_url
    "https://#{heroku_app_name}.herokuapp.com"
  end

  def compiled_site_path
    File.join(COMPILED_SITES_PATH, self.urn)
  end

  def homepage_compiled_file_path
    homepage.compiled_file_path if homepage
  end

  def record_type
    "g5-clw"
  end

  def to_param
    self.urn
  end

  private

  def build_default_website_template
    build_website_template(
      name: "Website Template",
      slug: "website-template",
      title: "Website Template"
    )
  end

  def build_default_web_page_template
    web_page_templates.build(
      name: "Home",
      slug: "home",
      title: "Home"
    )
  end

  def set_urn
    update_attributes(urn: "#{record_type}-#{id}-#{location_name.parameterize}")
  end
end
