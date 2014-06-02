require "spec_helper"

describe StaticWebsite::Compiler::AreaPage do
  let(:area_page) { described_class.new(base_path, slug, params) }
  let(:base_path) { "foo" }
  let(:slug) { "oregon" }
  let(:params) { { state: "oregon", city: nil, neighborhood: nil } }

  describe "#compile" do
    let(:compile_directory) { double(compile: nil) }

    before do
      StaticWebsite::Compiler::CompileDirectory.stub(new: compile_directory)
      area_page.stub(:render_to_file)
    end

    after { area_page.compile }

    it "passes the correct compile path to compile directory" do
      StaticWebsite::Compiler::CompileDirectory.should_receive(:new).with("foo/oregon/index.html", false)
    end

    it "calls compile on compile directory" do
      compile_directory.should_receive(:compile)
    end

    it "calls render_to_file on the class" do
      area_page.should_receive(:render_to_file)
    end
  end
end
