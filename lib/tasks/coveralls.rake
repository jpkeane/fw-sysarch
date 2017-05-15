namespace :coveralls do
  task push: :environment do
    require 'coveralls/rake/task'
    Coveralls::RakeTask.new
  end
end
