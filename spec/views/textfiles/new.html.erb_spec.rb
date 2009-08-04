require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/textfiles/new.html.erb" do
  include TextfilesHelper

  before(:each) do
    assigns[:textfile] = stub_model(Textfile,
      :new_record? => true,
      :filepath => "value for filepath",
      :content => "value for content"
    )
  end

  it "renders new textfile form" do
    render

    response.should have_tag("form[action=?][method=post]", textfiles_path) do
      with_tag("input#textfile_filepath[name=?]", "textfile[filepath]")
      with_tag("input#textfile_content[name=?]", "textfile[content]")
    end
  end
end
