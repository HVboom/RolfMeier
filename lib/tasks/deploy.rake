namespace :deploy do
  def run(command)
    puts "+ Running: #{command}"
    puts "-- #{system command}"
  end
  
  desc 'Copy attachments to download location'
  task :attachments => :environment do
    Document.deploy
  end

  desc 'Copy pictures to download location'
  task :pictures => :environment do
    Gallery.external.each do |gallery|
      ActsAsList.reorder_positions!(gallery.pictures)
    end
    Picture.deploy
  end

  desc 'Create static HTML pages'
  task :pages => :environment do
    Rake::Task['cache:clear:pages'].invoke
    Rake::Task['cache:refresh:pages'].invoke
  end

  desc 'Pre-Complile assets'
  task :compile => :environment do
    Rake::Task['assets:clean'].invoke
    Rake::Task['assets:precompile'].invoke
  end

  desc 'Push public pages to Git repository'
  task :git => :environment do
    FileUtils.cd('public') do
      FileUtils.cp('.htaccess.site', '.htaccess')
      message = "Site updated at #{Time.now.utc} by #{ENV['USER']}"
      run("git add -A . && git commit -am \"#{message}\"")
      run('git push')
      FileUtils.cp('.htaccess.passenger', '.htaccess')
    end
  end
end
