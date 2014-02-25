require "spec_helper"

describe StaticWebsite::Compiler::Javascripts do
  let(:javascripts_klass) { StaticWebsite::Compiler::Javascripts }
  let(:javascript_klass) { StaticWebsite::Compiler::Javascript }
  let(:javascript_path) { "http://codeorigin.jquery.com/jquery-2.0.3.min.js" }
  let(:compile_directory) { File.join(Rails.root, "tmp", "spec") }

  describe "#compile" do
    context "when javascripts is blank" do
      let(:subject) { javascripts_klass.new(nil, compile_directory) }

      it "does nothing" do
        expect(subject.compile).to be_nil
      end
    end

    context "when javascripts are present" do
      context "and previewing" do
        let(:preview) { true }
        let(:subject) { javascripts_klass.new([javascript_path],
          compile_directory, "", preview) }

        before do
          javascript_klass.any_instance.stub(:compile)
        end

        it "compiles each one" do
          subject.should_receive(:compile_javascript).once
          subject.compile
        end

        it "does not compress javascripts" do
          subject.javascript_compressor.should_not_receive(:compile)
          subject.compile
        end

        it "does not upload javascripts" do
          subject.javascript_uploader.should_not_receive(:compile)
          subject.compile
        end
      end

      context "and deploying" do
        let(:preview) { false }
        let(:subject) { javascripts_klass.new([javascript_path],
          compile_directory, "", preview) }

        before do
          javascript_klass.any_instance.stub(:compile)
        end

        it "compiles each one" do
          subject.should_receive(:compile_javascript).once
          subject.compile
        end

        # it "compresses javascripts" do
        #   subject.javascript_compressor.should_receive(:compile).once
        #   subject.compile
        # end

        it "uploads javascripts" do
          subject.javascript_uploader.should_receive(:compile).once
          subject.compile
        end
      end
    end
  end

  describe "#compile_javascript" do
    context "when javascripts is blank" do
      let(:subject) { javascripts_klass.new(nil, compile_directory) }

      it "does nothing" do
        expect(subject.compile_javascript(nil)).to be_nil
      end
    end

    context "when javascript is present" do
      let(:subject) { javascripts_klass.new(nil, compile_directory) }

      before do
        javascript_klass.any_instance.stub(:compile)
      end

      it "compile javascript" do
        javascript_klass.any_instance.should_receive(:compile).once
        subject.compile_javascript(javascript_path)
      end
    end
  end

  describe "#compressed_path" do
    let(:subject) { javascripts_klass.new(nil, compile_directory) }

    it "matches /javascripts/application.min.js" do
      expect(subject.compressed_path).to match "/javascripts/application.min.js"
    end
  end
end
