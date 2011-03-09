require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/textfiles/index.html.erb" do
  include TextfilesHelper

  before(:each) do
    @textfiles = [ Factory.create(:textfile, :filepath => "value for filepath"), Factory.create(:textfile) ]
    @textfiles.stub!(:current_page).and_return 1
    @textfiles.stub!(:num_pages).and_return 2
    @textfiles.stub!(:limit_value).and_return 1,1
    assigns[:textfiles] = @textfiles
    
    assigns[:search] = @search = Textfile.search({})
  end

  it "renders a list of textfiles" do
    render
    rendered.should contain("value for filepath")
  end
end
