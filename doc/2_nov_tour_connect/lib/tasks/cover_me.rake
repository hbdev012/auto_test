namespace :cover_me do

  desc "Generates and opens code coverage report."
  task :report do
    require 'cover_me'
    CoverMe.complete!
  end

  task :all      => %w{ rake:spec rake:cucumber report }
  task :spec     => %w{ rake:spec report }
  task :cucumber => %w{ rake:cucumber report }
end
