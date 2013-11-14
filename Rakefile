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