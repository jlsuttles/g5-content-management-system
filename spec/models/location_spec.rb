require File.dirname(__FILE__) + '/../spec_helper'

describe Location do
  before { Location.any_instance.stub(:hashed_id) { "im-an-id" }}
  let(:location) { Fabricate(:location, name: "Some Name") }

  describe "Validations" do
    it "should be valid" do
      Location.new.should be_valid
    end
  end

  describe "Colors" do
    describe "Custom" do
      before { location.stub(:custom_colors?) { true } }
      it { location.primary_color.should eq "#111111" }
      it { location.secondary_color.should eq "#222222" }
    end

    describe "Site Template" do
      it { location.primary_color.should eq "#000000" }
      it { location.secondary_color.should eq "#ffffff" }
      it do
        location.site_template.stub(:primary_color) { "#121212"}
        location.primary_color.should eq "#121212"
      end
      it do
        location.site_template.stub(:secondary_color) { "#212121"}
        location.secondary_color.should eq "#212121"
      end
    end
  end

  describe "Pages" do
    it "adds a page on creation" do
      expect { location }.to change(Page, :count).by(5)
    end

    it "doesn't count template as a page" do
      template = Page.create(location_id: location.id, name: "Template", template: true)
      location.pages.should_not include template
    end

    it "has a template as a page" do
      location.site_template.should_not be_blank
    end

    it "has a homepage" do
      location.homepage.slug.should eq "home"
    end

    it "has a collection of stylesheets" do
      location.stylesheets.should_not be_empty
    end
  end

  describe "Paths" do
    it do
      location.urn.should eq "g5-cl-im-an-id-some-name"
    end

    it "has a github repo" do
      location.github_repo.should eq "git@github.com:G5/static-heroku-app.git"
    end

    it "has a github repo" do
      location.heroku_repo.should eq "git@heroku.com:g5-cl-im-an-id-some-name.git"
    end
    
    it "param is urn" do
      location.to_param.should eq location.urn
    end

    it "has a 30 character heroku name" do
      Fabricate(:location, name: "Some Name That is way too longzzzzzz").heroku_app_name.length.should eq 30
    end

    it "has a heroku url" do
      location.heroku_url.should eq 'https://g5-cl-im-an-id-some-name.herokuapp.com'
    end

    it "has a homepage path" do
      location.homepage_compiled_file_path.should eq "#{location.compiled_site_path}/home.html"
    end
  end

end

