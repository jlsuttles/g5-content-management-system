require "spec_helper"

describe StaticWebsite::Compiler::Stylesheets do
  let(:stylesheets_klass) { StaticWebsite::Compiler::Stylesheets }
  let(:stylesheet_klass) { StaticWebsite::Compiler::Stylesheet }
  let(:stylesheet_path) { "http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" }
  let(:compile_directory) { File.join(Rails.root, "tmp", "spec") }

  describe "#compile" do
    context "when stylesheets is blank" do
      let(:subject) { stylesheets_klass.new(nil, compile_directory) }

      it "does nothing" do
        expect(subject.compile).to be_nil
      end
    end

    context "when stylesheets are present" do
      let(:subject) { stylesheets_klass.new([stylesheet_path], compile_directory) }

      before do
        subject.colors_stylesheet.stub(:compile)
        stylesheet_klass.any_instance.stub(:compile)
      end

      it "compiles colors stylesheet" do
        subject.colors_stylesheet.should_receive(:compile).once
        expect(subject.compile).to eq subject.stylesheet_paths
      end

      it "compiles each one" do
        subject.should_receive(:compile_stylesheet).once
        expect(subject.compile).to eq subject.stylesheet_paths
      end
    end
  end

  describe "#colors_stylesheet" do
    let(:subject) { stylesheets_klass.new(nil, compile_directory) }

    it "is a colors stylesheet object" do
      expect(subject.colors_stylesheet).to be_a StaticWebsite::Compiler::Stylesheet::Colors
    end
  end

  describe "#compile_stylesheet" do
    context "when stylesheets is blank" do
      let(:subject) { stylesheets_klass.new(nil, compile_directory) }

      it "does nothing" do
        expect(subject.compile_stylesheet(nil)).to be_nil
      end
    end

    context "when stylesheet is present" do
      let(:subject) { stylesheets_klass.new(nil, compile_directory) }

      before do
        stylesheet_klass.any_instance.stub(:compile)
      end

      it "compiles stylesheet" do
        stylesheet_klass.any_instance.should_receive(:compile).once
        subject.compile_stylesheet(stylesheet_path)
      end
    end
  end
end
