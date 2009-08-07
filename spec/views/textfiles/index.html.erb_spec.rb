require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/textfiles/index.html.erb" do
  include TextfilesHelper

  before(:each) do
    assigns[:textfiles] = [
      stub_model(Textfile,
        :filepath => "value for filepath",
        :content => "value for content"
      ),
      stub_model(Textfile,
        :filepath => "value for filepath",
        :content => "value for content"
      )
    ]
  end

  it "renders a list of textfiles" do
    render
    response.should have_tag("li", :text => "value for filepath")
  end
end
