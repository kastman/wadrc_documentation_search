require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/textfiles/show.html.erb" do
  include TextfilesHelper
  before(:each) do
    assigns[:textfile] = @textfile = stub_model(Textfile,
      :filepath => "value for filepath",
      :content => "value for content"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ filepath/)
    response.should have_text(/value\ for\ content/)
  end
end
