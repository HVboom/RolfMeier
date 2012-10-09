class UsersController < ApplicationController
  load_and_authorize_resource

  # GET /pictures
  # GET /pictures.json
  def index
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
end
