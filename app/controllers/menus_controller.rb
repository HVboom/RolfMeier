class MenusController < ApplicationController
  load_and_authorize_resource

  # GET /menus
  # GET /menus.json
  def index
    # give only the top level menu items to the view
    @menus = Menu.roots

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @menus }
    end
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /menus/new
  # GET /menus/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus
  # POST /menus.json
  def create
    respond_to do |format|
      if @menu.save
        format.html { redirect_to @menu, notice: 'Menu was successfully created.' }
        format.json { render json: @menu, status: :created, location: @menu }
      else
        format.html { render action: "new" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /menus/1
  # PUT /menus/1.json
  def update
    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to menus_url }
      format.json { head :no_content }
    end
  end

  # handle the sorting of menu items
  def sort
    menu = Menu.find_by_id(params['menu_id'])
    new_parent_id = params['parent_id'].to_i
    new_parent = Menu.find_by_id(new_parent_id) if(new_parent_id > 0)

    logger.debug "new_parent_id > 0 " + (new_parent_id > 0).to_s

    logger.debug "menu: #{menu.attributes.inspect}"
    logger.debug "new parent: #{new_parent.attributes.inspect}" if(new_parent)

    logger.debug "menu.parent != new_parent " + (menu.parent != new_parent).to_s
    if((new_parent_id > 0) && (menu.parent != new_parent))
      menu.move_to_child_of(new_parent)
    end

    if(params['position_id'].to_i > 0)
      sibling = Menu.find_by_id(params['position_id'])
      logger.debug "sibling: #{sibling.attributes.inspect}"
      new_position = (sibling.position > menu.position) ? sibling.position - 1 : sibling.position
      menu.insert_at(new_position)
    else
      logger.debug "set menu item as last"
      if(new_parent_id > 0)
        logger.debug "move to end of submenu items " + new_parent.children.length.to_s
        menu.insert_at(new_parent.children.length)
      else
        logger.debug "move to end of root menu items " + Menu.roots.length.to_s
        menu.insert_at(Menu.roots.length)
      end
    end

    render nothing: true
  end
end
