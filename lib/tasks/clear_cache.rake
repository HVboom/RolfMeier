namespace :cache do
  namespace :clear do
    desc 'Clears page cache'
    task :pages => :environment do
      cache_dir = ActionController::Base.page_cache_directory + '/pages'
      Rails.logger.info('Remove page cache from ' + cache_dir)
      FileUtils.rm_r(Dir.glob(cache_dir + '/*')) rescue Errno::ENOENT
    end
  end
end
