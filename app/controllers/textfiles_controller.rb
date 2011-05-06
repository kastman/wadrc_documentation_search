class TextfilesController < ApplicationController
  helper_method :sort_column, :sort_direction
  # GET /textfiles
  # GET /textfiles.xml
  def index
    if !params[:search].blank? && !params[:search][:meta_sort].blank?
      @search = Textfile.unscoped.search(params[:search])
    else
      @search = Textfile.search(params[:search])
    end
    
    @textfiles = @search.relation.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @textfiles }
      format.js
    end
  end

  # GET /textfiles/1
  # GET /textfiles/1.xml
  def show
    @search = Textfile.search(params[:search])
    @textfile = Textfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @textfile }
    end
  end

  # GET /textfiles/new
  # GET /textfiles/new.xml
  def new
    @textfile = Textfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @textfile }
    end
  end

  # GET /textfiles/1/edit
  def edit
    @search = Textfile.search(params[:search])
    @textfile = Textfile.find(params[:id])
  end

  # POST /textfiles
  # POST /textfiles.xml
  def create
    @textfile = Textfile.new(params[:textfile])
    @textfile.needs_fs_update = true
    @textfile.modified_at = Time.now

    respond_to do |format|
      if @textfile.save
        flash[:notice] = 'Textfile was successfully created.'
        format.html { redirect_to(@textfile) }
        format.xml  { render :xml => @textfile, :status => :created, :location => @textfile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @textfile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /textfiles/1
  # PUT /textfiles/1.xml
  def update
    @textfile = Textfile.find(params[:id])
    @textfile.needs_fs_update = true
    @textfile.modified_at = Time.now

    respond_to do |format|
      if @textfile.update_attributes(params[:textfile])
        flash[:notice] = 'Textfile was successfully updated.'
        format.html { redirect_to(@textfile) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @textfile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /textfiles/1
  # DELETE /textfiles/1.xml
  def destroy
    @textfile = Textfile.find(params[:id])
    @textfile.destroy

    respond_to do |format|
      format.html { redirect_to(textfiles_url) }
      format.xml  { head :ok }
    end
  end
  
  def sort_column
    Textfile.column_names.include?(params[:sort]) ? params[:sort] : "modified_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
