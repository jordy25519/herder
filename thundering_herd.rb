require 'fileutils'
# Find nonlinear startup time.
@group = ARGV[0].chomp
@upper = ARGV[1].chomp.to_i + 1
@tests = 3
@image_name = "aviarc-tagged"

def test(test_name, test_index)
 n = 19
 puts "textindex" + test_index.to_s
 #FileUtils.mkdir("tests/#{test_name}#{test_index}")
 while(n < @upper)
  `./herder --bench #{@image_name} #{n}`
  dur = []
  fin = []
  FileUtils.mv("tests/#{@image_name}s#{n}", "tests/#{test_name}#{test_index}/")
  
  Dir.glob("tests/#{test_name}#{test_index}/#{@image_name}s#{n}/*") do |d|
    lines =  IO.readlines(d)
    time = lines[-1][/[0-9]+.[0-9]+?/].to_f - lines[1][/[0-9]+.[0-9]+?/].to_f
    fin << lines[-1][/[0-9]+.[0-9]+?/].to_f
    dur << time
  end
  fin.sort!
  puts dur.count
  puts fin.count
  File.open("tests/#{test_name}#{test_index}/#{@image_name}s#{n}/stats.txt", "w") do |f|
    f.puts "#{dur.reduce(:+) / dur.size}" # avg elapsed
    f.puts "#{fin.reduce(:+) / fin.size}" # avg complete
    f.puts "#{fin.first}" # First Complete
    f.puts "#{fin.last}" # Last Complete
  end
 n += 1
 sleep 20
 end
end

## Main Script
@tests.times do |t|
 test(@group, t)
 puts "Test #{t} complete"
 sleep 30
end

puts "Calculating Averages..."

# For the nth test run
(@upper - 1).times do |i|
  stats = []
  n = 0
  
  puts i
  # Get averages from each test run from each group.
  Dir.glob("tests/#{@group}/*/#{@image_name}s#{i + 1}").each do |d|
    stats[n] =  IO.readlines(d + "/stats.txt").map &:to_f
    n = n + 1
  end
  
  avg = Hash.new
  avg["mean_complete"] = []
  avg["first_complete"] = []
  avg["last_complete"] = []
  avg["duration"] = []
  
  # Group averages from each group.
  @tests.times do |t|
   avg["last_complete"] << stats[t][-1]
   avg["first_complete"] << stats[t][-2]
   avg["mean_complete"] << stats[t][-3]
   avg["duration"] << stats[t][-4]  
  end
  # Consolidate final averages.
  final_averages = avg.map { |k, v| v.reduce(:+) / v.size }
 
  # Write averages to file.
  File.open("tests/#{@group}#{i}.txt", "w") do |f|
   f.puts "mean complete, first complete, last complete, duration"
   f.puts final_averages.to_s
  end
end

# Move test runs int one parent dir.
FileUtils.mkdir("tests/p#{@group}")
FileUtils.mv(Dir.glob("tests/#{@group}*"), "tests/p#{@group}/")

