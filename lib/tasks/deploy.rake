namespace :deploy do
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

  desc 'Zip application changes'
  task :zip => :environment do
  end
end
