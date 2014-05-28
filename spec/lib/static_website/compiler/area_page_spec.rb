require "spec_helper"

describe StaticWebsite::Compiler::AreaPage do
  let(:area_page) { described_class.new(base_path, slug) }
  let(:base_path) { "foo" }
  let(:slug) { "or" }

  describe "#compile" do
    subject { area_page.compile }
  end
end
