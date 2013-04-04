class Website < ActiveRecord::Base
  COMPILED_SITES_PATH = File.join(Rails.root, "tmp", "compiled_sites")
  attr_accessible :urn,
                  :custom_colors,
                  :primary_color,
                  :secondary_color

  belongs_to :location

  has_one :site_template, autosave: true
  has_many :pages, conditions: ["pages.type = ?", "Page"], autosave: true

  # templates are all templates for the website (site_template and pages)
  has_many :templates, class_name: "Page"
  # widgets are all widgets for the website (site_template and pages)
  has_many :widgets, through: :templates

  before_create :build_template
  after_create :build_homepage
  after_create :set_urn

  def location_name
    location ? location.name : ""
  end

  def primary_color
    if custom_colors?
      read_attribute(:primary_color)
    else
      site_template.try(:primary_color) || "#000000"
    end
  end

  def secondary_color
    if custom_colors?
      read_attribute(:secondary_color)
    else
      site_template.try(:secondary_color) || "#ffffff"
    end
  end

  def async_deploy
    Resque.enqueue(LocationDeployer, self.urn)
  end

  def deploy
    LocationDeployer.perform(self.urn)
  end

  def homepage
    pages.home.first
  end

  def stylesheets
    pages.map(&:stylesheets).flatten.uniq
  end

  def javascripts
    pages.map(&:javascripts).flatten.uniq
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

  def build_template
    build_site_template(
      name: "Site Template",
      slug: "site-template",
      title: "Site Template"
    )
  end

  def build_homepage
    pages.build(
      name: "Home",
      slug: "home",
      title: "Home"
    )
  end

  def set_urn
    update_attributes(urn: "#{record_type}-#{id}-#{location_name.parameterize}")
  end
end
