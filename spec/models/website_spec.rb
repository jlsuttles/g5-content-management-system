require 'spec_helper'

describe Website do
  before do
    # Website.any_instance.stub(:id).and_return(1)
    Website.any_instance.stub(:location_name).and_return("Awesome Location Name")
  end

  let(:website) { Fabricate(:website) }

  describe "validations" do
    it "is valid" do
      website.should be_valid
    end
  end

  describe "on create" do
    it "creates two pages" do
      expect { website }.to change(WebTemplate, :count).by(2)
    end
    it "creates a website_template" do
      website.website_template.should_not be_blank
    end
    it "creates a homepage" do
      website.homepage.slug.should eq "home"
    end
  end

  describe "#web_templates" do
    it "includes website_template" do
      website.web_templates.should include website.website_template
    end
    it "includes pages" do
      website.web_templates.should include website.web_page_templates.first
    end
  end

  describe "#website_template" do
    it "returns the site template, not a page" do
      website.website_template.should be_kind_of(WebsiteTemplate)
    end
  end

  describe "#web_page_templates" do
    it "returns web page template, not web template" do
      website.web_page_templates.first.should be_kind_of(WebPageTemplate)
    end
  end

  describe "colors" do

    describe "without site template" do
      it "uses website's primany color #000000" do
        website.primary_color.should eq "#000000"
      end
      it "uses website's secondary color #ffffff" do
        website.secondary_color.should eq "#ffffff"
      end
    end

    describe "with a site template" do
      let (:website_template) { website.website_template }
      before do
        website_template.stub(:primary_color).and_return("#333333")
        website_template.stub(:secondary_color).and_return("#444444")
      end
      context "when not using custom colors" do
        it "uses site template's default primany color #000000" do
          website.primary_color.should eq website_template.primary_color
        end
        it "uses site template's default secondary color #ffffff" do
          website.secondary_color.should eq website_template.secondary_color
        end
      end
      context "when using custom colors" do
        before do
          website.stub(:custom_colors?).and_return(true)
        end
        it "uses the website's custom color #000000" do
          website.primary_color.should eq "#000000"
        end
        it "uses the website's custom color #ffffff" do
          website.secondary_color.should eq "#ffffff"
        end
      end
    end
  end

  describe "#stylesheets" do
    it "has a collection of stylesheets" do
      website.stylesheets.should_not be_empty
    end
  end

  describe "Paths" do
    it do
      website.urn.should eq "g5-clw-1-awesome-location-name"
    end

    it "param is urn" do
      website.to_param.should eq website.urn
    end

    it "has a github repo" do
      website.github_repo.should eq "git@github.com:G5/static-heroku-app.git"
    end

    it "has a github repo" do
      website.heroku_repo.should eq "git@heroku.com:g5-clw-1-awesome-location-name.git"
    end

    it "has a 30 character heroku name" do
      Fabricate(:website).heroku_app_name.length.should eq 30
    end

    it "has a heroku url" do
      website.heroku_url.should eq 'https://g5-clw-1-awesome-location-name.herokuapp.com'
    end

    it "has a homepage path" do
      website.homepage_compiled_file_path.should eq "#{website.compiled_site_path}/home.html"
    end
  end

end
