require 'spec_helper'

describe AWSSigner do
  subject do
    AWSSigner.new({'locationName' => 'foobarlocation'})
  end

  describe "#upload_headers" do
    it "returns a hash of header items" do
      subject.upload_headers.should include :acl => "public-read"
    end
  end  

  describe "#delete_headers" do
    it "returns a hash of header items" do
      subject.delete_headers.should include :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID']
    end
  end  
end

