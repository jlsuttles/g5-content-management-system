require 'spec_helper'
require 'timecop'

describe AWSSigner do
  subject do
    AWSSigner.new({:locationName => 'foobarlocation',
                   :name => 'file with spaces.something.jpg'})
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
      subject.upload_headers.should include :key => "uploads/file-with-spaces.something.jpg"
    end
  end  

  describe "#delete_headers" do
    it "returns a hash of header items" do
      subject.delete_headers.should include :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID']
      subject.delete_headers.should include \
        :signature => "1b6957b80766631398569aaeefb3d8ab485029eb26e8e956435e032fbb462961"
    end
  end  
end

