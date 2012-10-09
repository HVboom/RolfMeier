class HomeController < ApplicationController
  load_and_authorize_resource class: User

  def index
    @users = User.all
  end
end
