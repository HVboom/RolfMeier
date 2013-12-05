class DeploymentController < ApplicationController
  # skip_authorization_check
  authorize_resource :class => false

  def deploy
    # collect attachemnts
    call_rake('deploy:attachments')
    # collect slide show galleries
    call_rake('deploy:pictures')
    # cache all public pages
    call_rake('deploy:pages', :host => request.host_with_port, :index_page => params[:deploy][:index_page])
    # freshly pre-compile all assets
    call_rake('deploy:compile')
    # push everything to the git repository and with an postprocessing hook to the live site
    call_rake('deploy:git', :user => @current_user.name)
    # clean the assets to be back in development mode, if necessary
    call_rake('assets:clean') unless Rails.env.production?

    flash[:notice] = 'Collecting files to deploy and push it to the site: ' + request.host_with_port +
                     ' using index page: ' + Page.find(params[:deploy][:index_page]).slug

    respond_to do |format|
      format.html { redirect_to deployment_url }
      format.json { head :no_content }
    end
  end

  def index
  end
end
