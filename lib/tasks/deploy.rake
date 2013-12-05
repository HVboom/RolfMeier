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
  task :pages, [:host, :index_page] => :environment do |task, args|
    puts "PageDeploy - 1: #{args.host} and #{args.index_page}"
    args.with_defaults(:host => ENV['HOST'] || 'rm.dev.hvboom.org', :index_page => ENV['INDEX_PAGE'] || Page.contact.id)
    puts "PageDeploy - 2: #{args.host} and #{args.index_page}"

    Rake::Task['cache:clear:pages'].invoke
    # Rake::Task['cache:refresh:pages'].invoke
    Page.deploy(args.host, args.index_page)
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
      FileUtils.rm_f('index.html')
    end
  end
end
