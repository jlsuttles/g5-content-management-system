require 'spec_helper'

class HentryableDatesTester
  include HentryableDates
end

describe HentryableDates do
  COMPUTER_REGEX = /#{Time::DATE_FORMATS[:computer].gsub(/%./, "\\d+")}/
  HUMAN_REGEX = /#{Time::DATE_FORMATS[:human].gsub(/%./, ".+")}/

  let(:tester) { HentryableDatesTester.new }
  before { tester.stub_chain(:model, :created_at).and_return(Time.now) }
  before { tester.stub_chain(:model, :updated_at).and_return(Time.now) }

  describe "#created_at_computer_readable" do
    it "is computer readable" do
      tester.created_at_computer_readable.should match COMPUTER_REGEX
    end
  end

  describe "#created_at_human_readable" do
    it "is human readable" do
      tester.created_at_human_readable.should match HUMAN_REGEX
    end
  end

  describe "#updated_at_computer_readable" do
    it "is computer readable" do
      tester.updated_at_computer_readable.should match COMPUTER_REGEX
    end
  end

  describe "#updated_at_human_readable" do
    it "is human readable" do
      tester.updated_at_human_readable.should match HUMAN_REGEX
    end
  end
end
