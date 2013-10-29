class DeploymentController < ApplicationController
  skip_authorization_check

  def deploy
    # collect attachemnts
    call_rake('deploy:attachments')
    # collect slide show galleries
    call_rake('deploy:pictures')
    # cache all public pages
    call_rake('deploy:pages')
    # freshly pre-compile all assets
    call_rake('deploy:compile')
    # push everything to the git repository and with an postprocessing hook to the live site
    call_rake('deploy:git', :user => @current_user)
    # clean the assets to be back in development mode, if necessary
    call_rake('assets:clean') unless Rails.env.production?

    flash[:notice] = 'Collecting files to deploy and push it to the site.'

    respond_to do |format|
      format.html { redirect_to deployment_url }
      format.json { head :no_content }
    end
  end

  def index
  end
end
