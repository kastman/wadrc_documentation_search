require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TextfilesController do
  describe "route generation and recognition" do
    it "maps #index" do
      {:get => "/textfiles"}.should route_to(:controller => "textfiles", :action => "index")
    end

    it "maps #new" do
      {:get => "/textfiles/new"}.should route_to(:controller => "textfiles", :action => "new")
    end

    it "maps #show" do
      {:get => "/textfiles/1"}.should route_to(:controller => "textfiles", :action => "show", :id => "1")
    end

    it "maps #edit" do
      {:get => "/textfiles/1/edit"}.should route_to(:controller => "textfiles", :action => "edit", :id => "1")
    end

    it "maps #create" do
      {:post => "/textfiles"}.should route_to(:controller => "textfiles", :action => "create")
    end

    it "maps #update" do
      {:put => "/textfiles/1"}.should route_to(:controller => "textfiles", :action => "update", :id => "1")
    end

    it "maps #destroy" do
      {:delete => "/textfiles/1"}.should route_to(:controller => "textfiles", :action => "destroy", :id => "1")
    end
  end    
end
