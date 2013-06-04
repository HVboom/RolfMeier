class DeploymentController < ApplicationController
  skip_authorization_check

  def deploy
    call_rake 'deploy:attachments'
    call_rake 'deploy:pages'
    call_rake 'deploy:compile'
    flash[:notice] = 'Collecting files to deploy.'
    redirect_to root_path
  end

  def index
  end
end
