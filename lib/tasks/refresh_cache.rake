namespace :cache do
  namespace :refresh do
    desc 'Refresh page cache'
    task :pages => :environment do
      require 'rails/console/app'
      require 'rails/console/helpers'
      extend Rails::ConsoleMethods

      include Rails.application.routes.url_helpers

      ApplicationController.allow_forgery_protection = false

      # login into application
      status = app.post('/users/login', {:user => {:email => 'mario@hvboom.ch', :password => 'Nadur13'}})
      $stdout.puts "#{status}"

      # iterate through all pages
      Page.all.each do |page|
        # url = "/pages/#{page.slug}"
        url = page_url(page)
        $stdout.puts "#{url}"
        status = app.get(url)
        unless 200 == status
          $stderr.puts "Error generating static file #{page_path(page)} #{status.inspect}"
        end
      end
    end
  end
end
