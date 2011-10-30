class PhotosController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]

  caches_page :index, :show
  cache_sweeper :photo_sweeper, :only => [:update, :create, :destroy]

  # GET /photos
  # GET /photos.xml
  def index

    # TODO: sort by published photos, only
    @photos = Photo.find(:all, :order => "pub_date DESC", :conditions => "pub_date <= NOW()", :limit => 15)

    @latest_photo = @photos.first
    @previous_photo = @photos[1]

    @page_title = @latest_photo.pub_date.to_formatted_s(:month_day_year)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
      format.atom
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])

    #TODO these could be totally optimized instead of doing additional SQL calls
    @previous_photo = @photo.prev
    @next_photo = @photo.next

    @page_title = @photo.pub_date.to_formatted_s(:month_day_year)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.xml
  def create
    @photo = Photo.new(params[:photo])

    respond_to do |format|
      if @photo.save
        # flash[:notice] = 'Photo was successfully created.'
        format.html { redirect_to(@photo) }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        # flash[:notice] = 'Photo was successfully updated.'
        format.html { redirect_to(@photo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to(photos_url) }
      format.xml  { head :ok }
    end
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == APP_CONFIG[:username] && password == APP_CONFIG[:password]
    end
  end
end
