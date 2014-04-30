require "spec_helper"

describe URLFormat::SingleDomainFormatter do
  let!(:client) { Fabricate(:client, type: "SingleDomainClient") }
  let(:owner) { Fabricate.build(:location, city_slug: "Bend") }
  let(:web_template) { Fabricate.build(:web_template, slug: "foo", type: type) }

  subject { described_class.new(web_template, owner).format }


  context "home template" do
    let(:type) { "WebHomeTemplate" }

    it { should eq("/#{client.vertical_slug}/#{owner.state_slug}" \
                   "/#{owner.city_slug}/#{owner.urn}") }
  end

  context "other templates" do
    let(:type) { "WebPageTemplate" }

    it { should eq("/#{client.vertical_slug}/#{owner.state_slug}" \
                   "/#{owner.city_slug}/#{owner.urn}/#{web_template.slug}") }
  end
end
