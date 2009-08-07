require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/textfiles/edit.html.erb" do
  include TextfilesHelper

  before(:each) do
    assigns[:textfile] = @textfile = stub_model(Textfile,
      :new_record? => false,
      :filepath => "value for filepath",
      :content => "value for content"
    )
  end

  it "renders the edit textfile form" do
    render

    response.should have_tag("form[action=#{textfile_path(@textfile)}][method=post]") do
      #with_tag('input#textfile_filepath[name=?]', "textfile[filepath]")
      with_tag('#textfile_content[name=?]', "textfile[content]")
    end
  end
end
