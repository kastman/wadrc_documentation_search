require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Textfile do
  before(:each) do
    @valid_attributes = {
      :filepath => "value for filepath",
      :content => "value for content",
      :owner => 'erik',
      :modified_at => Time.now,
      :accessed_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Textfile.create!(@valid_attributes)
  end
end
