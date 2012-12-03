task :ci do
  {"Acceptance" => "spec/acceptance",
   "Unit" => "`ls -1d spec/* | egrep -v *.rb | egrep -v */acceptance`"}.each do |name,tests|
    puts "Starting to run #{name} tests..."
    system("bundle exec rspec #{tests}")
    raise "#{name} tests failed!" unless $?.exitstatus == 0
  end
end
