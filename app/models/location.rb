class Location < ActiveRecord::Base
  COMPILED_SITES_PATH = File.join(Rails.root, "tmp", "compiled_sites")
  #TODO remove this if location will not have a concept of address
  liquid_methods :address

  attr_accessible :uid, :name, :corporate, :urn, :primary_color, :secondary_color, :custom_colors

  has_one :site_template
  has_many :pages, conditions: ["pages.type = ?", "Page"]

  before_create :create_template
  after_create :create_homepage
  after_create :set_urn

  #TODO remove this if location will not have a concept of address
  def address
    "12345 greenwood ave, bend OR"
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
    "g5-cl"
  end

  def hashed_id
    "#{self.created_at.to_i}#{self.id}".to_i.to_s(36)
  end

  def to_param
    self.urn
  end

  private

  def set_urn
    update_attributes(urn: "#{record_type}-#{hashed_id}-#{name.parameterize}")
  end

  def create_template
    create_site_template(name: "Site Template", slug: "site-template", title: "Site Template")
  end

  def create_homepage
    pages.create(name: "Home", slug: "home", title: "Home")
  end
end
