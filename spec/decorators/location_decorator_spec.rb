require 'spec_helper'

describe LocationDecorator do
  let!(:location) { Fabricate(:location) }
  let(:decorated_location) { location.decorate }

  describe "#address" do
    subject { decorated_location.address }

    it { should eq("#{location.street_address}, #{location.city}, " \
                   "#{location.state} #{location.postal_code}") }
  end
end

