require "spec_helper"

describe URLFormat::SingleDomainFormatter do
  let!(:client) { Fabricate(:client, type: "SingleDomain") }
  let(:owner) { Fabricate.build(:location, city_slug: "Bend") }
  let(:web_template) { Fabricate.build(:web_template, slug: "foo") }

  subject { described_class.new(web_template, owner).format }

  it { should eq("/#{client.vertical_slug}/#{owner.state_slug}" \
                 "/#{owner.city_slug}/#{owner.urn}/#{web_template.slug}") }
end
