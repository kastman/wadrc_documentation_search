require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TextfilesController do

  def mock_textfile(stubs={})
    @mock_textfile ||= mock_model(Textfile, stubs)
  end

  describe "GET index" do
    it "assigns all textfiles as @textfiles" do
      Textfile.stub!(:find).with(:all).and_return([mock_textfile])
      #get :index
      #assigns[:textfiles].should == [mock_textfile]
    end
  end

  describe "GET show" do
    it "assigns the requested textfile as @textfile" do
      Textfile.stub!(:find).with("37").and_return(mock_textfile)
      get :show, :id => "37"
      assigns[:textfile].should equal(mock_textfile)
    end
  end

  describe "GET new" do
    it "assigns a new textfile as @textfile" do
      Textfile.stub!(:new).and_return(mock_textfile)
      get :new
      assigns[:textfile].should equal(mock_textfile)
    end
  end

  describe "GET edit" do
    it "assigns the requested textfile as @textfile" do
      Textfile.stub!(:find).with("37").and_return(mock_textfile)
      get :edit, :id => "37"
      assigns[:textfile].should equal(mock_textfile)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created textfile as @textfile" do
        Textfile.stub!(:new).with({'these' => 'params'}).and_return(mock_textfile(:save => true))
        post :create, :textfile => {:these => 'params'}
        assigns[:textfile].should equal(mock_textfile)
      end

      it "redirects to the created textfile" do
        Textfile.stub!(:new).and_return(mock_textfile(:save => true))
        post :create, :textfile => {}
        response.should redirect_to(textfile_url(mock_textfile))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved textfile as @textfile" do
        Textfile.stub!(:new).with({'these' => 'params'}).and_return(mock_textfile(:save => false))
        post :create, :textfile => {:these => 'params'}
        assigns[:textfile].should equal(mock_textfile)
      end

      it "re-renders the 'new' template" do
        Textfile.stub!(:new).and_return(mock_textfile(:save => false))
        post :create, :textfile => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested textfile" do
        Textfile.should_receive(:find).with("37").and_return(mock_textfile)
        mock_textfile.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :textfile => {:these => 'params'}
      end

      it "assigns the requested textfile as @textfile" do
        Textfile.stub!(:find).and_return(mock_textfile(:update_attributes => true))
        put :update, :id => "1"
        assigns[:textfile].should equal(mock_textfile)
      end

      it "redirects to the textfile" do
        Textfile.stub!(:find).and_return(mock_textfile(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(textfile_url(mock_textfile))
      end
    end

    describe "with invalid params" do
      it "updates the requested textfile" do
        Textfile.should_receive(:find).with("37").and_return(mock_textfile)
        mock_textfile.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :textfile => {:these => 'params'}
      end

      it "assigns the textfile as @textfile" do
        Textfile.stub!(:find).and_return(mock_textfile(:update_attributes => false))
        put :update, :id => "1"
        assigns[:textfile].should equal(mock_textfile)
      end

      it "re-renders the 'edit' template" do
        Textfile.stub!(:find).and_return(mock_textfile(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested textfile" do
      Textfile.should_receive(:find).with("37").and_return(mock_textfile)
      mock_textfile.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the textfiles list" do
      Textfile.stub!(:find).and_return(mock_textfile(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(textfiles_url)
    end
  end

end
