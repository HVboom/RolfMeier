namespace :cache do
  namespace :refresh do
    desc 'Refresh page cache'
    task :pages => :environment do
      require 'rails/console/app'
      require 'rails/console/helpers'
      extend Rails::ConsoleMethods

      # login into application
      ApplicationController.allow_forgery_protection = false
      app.post('/users/login', {:user => {:email => 'mario@hvboom.ch', :password => 'Nadur13'}})

      # iterate through all pages
      Page.all.each do |page|
        url = "/pages/#{page.slug}"
        status = app.get(url)
        unless 200 == status
          $stderr.puts "Error generating static file #{page_path(page)} #{status.inspect}"
        end
      end
    end
  end
end
