class PicturesController < ApplicationController
  load_and_authorize_resource

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.newest

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render json: @picture, status: :created, location: @picture }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to pictures_url }
      format.json { head :no_content }
    end
  end

  # handle the sorting of pictures in a gallery
  def sort
    picture = Picture.find_by_id(params['picture_id'])
    new_gallery_id = params['gallery_id'].to_i
    new_gallery = Gallery.find_by_id(new_gallery_id) if(new_gallery_id > 0)

    # logger.debug "new_gallery_id > 0 " + (new_gallery_id > 0).to_s

    # logger.debug "picture: #{picture.attributes.inspect}"
    # logger.debug "new gallery: #{new_gallery.attributes.inspect}" if(new_gallery)

    # logger.debug "picture.gallery != new_gallery " + (picture.gallery != new_gallery).to_s
    if(picture.gallery != new_gallery)
      if(new_gallery_id > 0)
        picture.gallery = new_gallery
      else
        picture.gallery = nil
      end
      # picture.position = 0
      picture.save
    end

    if(params['position_id'].to_i > 0)
      sibling = Picture.find_by_id(params['position_id'])
      # logger.debug "sibling: #{sibling.attributes.inspect}"
      # if the move goes down the list, the insert has to be done before the sibling, instead of the sibling position
      new_position = (sibling.position > picture.position) ? sibling.position - 1 : sibling.position
      picture.insert_at(new_position)
    else
      # logger.debug "set picture as last"
      picture.move_to_bottom()
    end

    render nothing: true
  end
end
