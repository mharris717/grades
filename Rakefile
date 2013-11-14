task :loop do
  loop do
    puts "\n\n\n\n"
    puts `rspec specs.rb`
    sleep(0.2)
  end
end

task :spec do
  puts `rspec specs.rb`
end

task :run do
  load "grades.rb"
  Grades.run!
end

task :clean do
  `rm classes/*_averages.txt`
end