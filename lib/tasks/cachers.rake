namespace :cachers do
  desc 'Cache all records.'
  task cache: :environment do
    Cachers.cache
  end

  desc 'Recache all records.'
  task recache: :environment do
    Cachers.recache
  end

  desc 'Uncache all records.'
  task uncache: :environment do
    Cachers.uncache
  end
end
