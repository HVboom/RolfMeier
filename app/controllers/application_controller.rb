class ApplicationController < ActionController::Base
  protect_from_forgery

  # before_filter :authenticate_user!
  check_authorization :unless => :devise_controller?

  # all models influence the cached pages
  cache_sweeper :page_sweeper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path(:format => nil), :alert => exception.message
  end

  # handle unknown requests by redirection to root always
  unless Rails.application.config.consider_all_requests_local
    rescue_from AbstractController::ActionNotFound, with: :handle_error
    rescue_from ActiveRecord::RecordNotFound, with: :handle_error
    rescue_from ActionController::RoutingError, with: :handle_error
    rescue_from ActionController::UnknownController, with: :handle_error
    rescue_from ActionController::UnknownAction, with: :handle_error
  end

  protected
    def handle_error
      redirect_to root_path(:format => nil), status: :moved_permanently
    end

  private
    # see railscast episode - http://railscasts.com/episodes/127-rake-in-background
    def call_rake(task, options = {})
      options[:rails_env] ||= Rails.env
      args = options.map { |n, v| "#{n.to_s.upcase}='#{v}'" }
      # system "time `which rake` #{task} #{args.join(' ')} --trace >> #{Rails.root}/log/rake.log 2>&1 &"
      # run synchron
      system "`which rake` --jobs 1 #{task} #{args.join(' ')} --trace >> #{Rails.root}/log/rake.log 2>&1"
    end

    # force html extension on all standard link (necessary for the static page files)
    def default_url_options(options = nil)
      {:format => 'html'}
    end
end
