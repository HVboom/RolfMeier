# encoding: utf-8

class PagesController < ApplicationController
  # disable devise to access page
  skip_before_filter :authenticate_user!, :only => :show

  # disable cancan to access page
  load_and_authorize_resource :except => :show
  load_resource :only => :show
  skip_authorization_check :only => :show

  # cache pages as deploy preparation
  caches_page :show

  # GET /pages
  # GET /pages.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    unless @page.address.blank?
      #@map = @page.to_gmaps4rails do |page, marker|
        #marker.infowindow render_to_string(:partial => 'infowindow', :locals => {:page => page})
        #marker.title page.address
      #end
      @map = Gmaps4rails.build_markers(@page) do |page, marker|
        marker.lat page.latitude
        marker.lng page.longitude
        marker.infowindow render_to_string(:partial => 'infowindow', :locals => {:page => page})
        marker.title page.address
      end
    end
    # redirect to actual user friendly URL, e.g. pages/4 => pages/kontakt
    if request.path != page_path(@page)
      redirect_to @page, status: :moved_permanently
    else
      respond_to do |format|
        format.html { render :layout => 'showroom' } # show.html.erb
        format.json { render json: @page }
      end
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    expire_page :action => :show

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy

    expire_page :action => :show

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end
end
