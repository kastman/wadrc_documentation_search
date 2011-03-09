require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/textfiles/edit.html.erb" do
  include TextfilesHelper

  before(:each) do
    @textfile = stub_model(Textfile,
      :new_record? => false,
      :filepath => "value for filepath",
      :content => "value for content"
    )
    
    assign(:textfile, @textfile)
  end

  it "renders the edit textfile form" do
    render

    rendered.should have_selector("form", :action => textfile_path(@textfile), :method => "post") do |form|
      form.should have_selector('textarea#textfile_content', :name => 'textfile[content]')
    end
  end
end
