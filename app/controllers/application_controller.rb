class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  check_authorization :unless => :devise_controller?

  # all models influence the cached pages
  cache_sweeper :page_sweeper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  private
    # see railscast episode - http://railscasts.com/episodes/127-rake-in-background
    def call_rake(task, options = {})
      options[:rails_env] ||= Rails.env
      args = options.map { |n, v| "#{n.to_s.upcase}='#{v}'" }
      system "time `which rake` #{task} #{args.join(' ')} --trace >> #{Rails.root}/log/rake.log 2>&1 &"
    end
end
