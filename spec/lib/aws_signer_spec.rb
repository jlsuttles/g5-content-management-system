require 'spec_helper'
require 'timecop'

describe AWSSigner do
  subject do
    AWSSigner.new({'locationName' => 'foobarlocation'})
  end

  before do
    Timecop.freeze(DateTime.new(1983,8,17))
  end

  after do
    Timecop.return
  end

  describe "#upload_headers" do
    it "returns a hash of header items" do
      subject.upload_headers.should include :acl => "public-read"
      subject.upload_headers.should include \
        :signature => "fXrnzlPiA0UcfRsRYj2Ye/6hXLU="
    end
  end  

  describe "#delete_headers" do
    it "returns a hash of header items" do
      subject.delete_headers.should include :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID']
      subject.delete_headers.should include \
        :signature => "81c3fd5fcf8f6e86e57c8960186c90e0c63d71303cab4424007c7ea156d0337a"
    end
  end  
end

