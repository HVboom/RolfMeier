class DeploymentController < ApplicationController
  skip_authorization_check

  def deploy
    call_rake 'deploy:attachments'
    call_rake 'deploy:pictures'
    call_rake 'deploy:pages'
    call_rake 'deploy:compile'
    call_rake 'deploy:git'
    flash[:notice] = 'Collecting files to deploy and push it to the site.'
    redirect_to root_path
  end

  def index
  end
end
