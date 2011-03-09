require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/textfiles/show.html.erb" do
  include TextfilesHelper
  before(:each) do
    assigns[:textfile] = @textfile = Factory(:textfile, {:filepath => "value for filepath",
    :content => "value for content"})
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("value for filepath")
    rendered.should contain("value for content")
  end
end
