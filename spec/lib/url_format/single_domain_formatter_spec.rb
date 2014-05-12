require "spec_helper"

describe URLFormat::SingleDomainFormatter do
  let!(:client) { Fabricate(:client, type: "SingleDomainClient") }
  let!(:website) { Fabricate.build(:website, urn: "foo-bar", owner: owner) }
  let(:owner) { Fabricate.build(:location, city_slug: "Bend") }
  let(:web_template) { Fabricate.build(:web_template, website: website, slug: "foo", type: type) }

  subject { described_class.new(web_template, owner).format }

  context "location" do
    context "home template" do
      let(:type) { "WebHomeTemplate" }

      it { should eq("/#{website.urn}/#{client.vertical_slug}/#{owner.state_slug}" \
                     "/#{owner.city_slug}") }
    end

    context "other templates" do
      let(:type) { "WebPageTemplate" }

      it { should eq("/#{website.urn}/#{client.vertical_slug}/#{owner.state_slug}" \
                     "/#{owner.city_slug}/#{web_template.slug}") }
    end
  end

  context "corporate" do
    let(:owner) { Fabricate.build(:location, city_slug: "Bend", corporate: true) }

    context "home template" do
      let(:type) { "WebHomeTemplate" }

      it { should eq("/") }
    end

    context "other templates" do
      let(:type) { "WebPageTemplate" }

      it { should eq("/#{web_template.slug}") }
    end
  end
end
