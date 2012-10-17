require File.dirname(__FILE__) + '/../spec_helper'

describe Client do
  def new_client(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    Client.new(attributes)
  end

  before(:each) do
    Client.delete_all
  end

  it "should be valid" do
    new_client.should be_valid
  end

  it "should require username" do
    new_client(:username => '').should have(1).error_on(:username)
  end

  it "should require password" do
    new_client(:password => '').should have(1).error_on(:password)
  end

  it "should require well formed email" do
    new_client(:email => 'foo@bar@example.com').should have(1).error_on(:email)
  end

  it "should validate uniqueness of email" do
    new_client(:email => 'bar@example.com').save!
    new_client(:email => 'bar@example.com').should have(1).error_on(:email)
  end

  it "should validate uniqueness of username" do
    new_client(:username => 'uniquename').save!
    new_client(:username => 'uniquename').should have(1).error_on(:username)
  end

  it "should not allow odd characters in username" do
    new_client(:username => 'odd ^&(@)').should have(1).error_on(:username)
  end

  it "should validate password is longer than 3 characters" do
    new_client(:password => 'bad').should have(1).error_on(:password)
  end

  it "should require matching password confirmation" do
    new_client(:password_confirmation => 'nonmatching').should have(1).error_on(:password)
  end

  it "should generate password hash and salt on create" do
    client = new_client
    client.save!
    client.password_hash.should_not be_nil
    client.password_salt.should_not be_nil
  end

  it "should authenticate by username" do
    client = new_client(:username => 'foobar', :password => 'secret')
    client.save!
    Client.authenticate('foobar', 'secret').should == client
  end

  it "should authenticate by email" do
    client = new_client(:email => 'foo@bar.com', :password => 'secret')
    client.save!
    Client.authenticate('foo@bar.com', 'secret').should == client
  end

  it "should not authenticate bad username" do
    Client.authenticate('nonexisting', 'secret').should be_nil
  end

  it "should not authenticate bad password" do
    new_client(:username => 'foobar', :password => 'secret').save!
    Client.authenticate('foobar', 'badpassword').should be_nil
  end
end
