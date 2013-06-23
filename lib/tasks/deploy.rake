namespace :deploy do
  def say(msg, &block)
    print "#{msg}..."

    if block_given?
      quietly do
        yield
      end
      puts ' Done.'
    end
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
    say 'Push public pages to Git repository' do
      cd 'public' do
        sh 'git add .'
        message = "Site updated at #{Time.now.utc}"
        sh "git commit -am \"#{message}\""
        sh 'git push'
      end
    end
  end
end
