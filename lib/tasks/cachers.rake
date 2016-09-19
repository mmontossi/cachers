namespace :cachers do
  desc 'Finds each model cacheable and cache all his records.'
  task cache: :environment do
    Cachers.cache
  end

  desc 'Finds each model cacheable and recache all his records.'
  task recache: :environment do
    Cachers.recache
  end

  desc 'Finds each model cacheable and uncache all his records.'
  task uncache: :environment do
    Cachers.uncache
  end
end
