require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/textfiles/new.html.erb" do
  include TextfilesHelper

  before(:each) do
    assigns[:textfile] = @textfile = stub_model(Textfile,
      :filepath => "value for filepath",
      :content => "value for content",
      :owner => 'erik',
      :accessed_at => Time.now,
      :modified_at => Time.now
    ).as_new_record
  end

  it "renders new textfile form" do
    render

    rendered.should have_selector("form", :action => textfiles_path, :method => 'post') do |form|
      form.should have_selector("input#textfile_filepath", :name => "textfile[filepath]")
      form.should have_selector("textarea#textfile_content", :name => "textfile[content]")
    end
  end
end
