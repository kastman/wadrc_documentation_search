require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TextfilesController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "textfiles", :action => "index").should == "/textfiles"
    end

    it "maps #new" do
      route_for(:controller => "textfiles", :action => "new").should == "/textfiles/new"
    end

    it "maps #show" do
      route_for(:controller => "textfiles", :action => "show", :id => "1").should == "/textfiles/1"
    end

    it "maps #edit" do
      route_for(:controller => "textfiles", :action => "edit", :id => "1").should == "/textfiles/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "textfiles", :action => "create").should == {:path => "/textfiles", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "textfiles", :action => "update", :id => "1").should == {:path =>"/textfiles/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "textfiles", :action => "destroy", :id => "1").should == {:path =>"/textfiles/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/textfiles").should == {:controller => "textfiles", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/textfiles/new").should == {:controller => "textfiles", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/textfiles").should == {:controller => "textfiles", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/textfiles/1").should == {:controller => "textfiles", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/textfiles/1/edit").should == {:controller => "textfiles", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/textfiles/1").should == {:controller => "textfiles", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/textfiles/1").should == {:controller => "textfiles", :action => "destroy", :id => "1"}
    end
  end
end
