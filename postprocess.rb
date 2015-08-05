# Post-process .CSV output to calculate cumulative statistics.
require 'tempfile'
require 'fileutils'

class PostProcess
		
	def execute(test_dir)
		@keys = ["timestamp","cpu_user","cpu_system","cpu_time","rchar","wchar","syscr","syscw","rbytes","wbytes","cbytes","rss","cpu_time_instant","rchar_instant","wchar_instant","rss_instant"]

		puts "Commencing CSV postprocessing..."
		@keys = Hash[@keys.each_with_index.map { |i, v| [i, v] }]
	
		Dir.glob("./tests/#{test_dir}/*").each do |file|
			csv = IO.readlines(file)
			name = File.basename(file)
			new_file = process(name, csv)
			FileUtils.mv(new_file, file)
		end

		puts "CSV postprocessing complete."
	
	end
	
	def to_csv(*data)
		data.map! &:to_s
		data.join(",")
	end
	
	# Split the csv line by line and do calculations.
	# Returns a new modified file.
	def process(name, file)
	
		old_line = ""
		new_file = Tempfile.new(name)	
	
		file.each_with_index do |line, i|
			
			# Add extra fields to header.
			if i == 0
				new_file.puts @keys.keys.join(",")
			
			# First line copy across values.
			elsif i == 1
				data = line.split(",")
				cpu_time = data[@keys["cpu_time"]]
				rchar = data[@keys["rchar"]]
				wchar = data[@keys["wchar"]]
				rss = data[@keys["rss"]]
				new_file.puts to_csv(line.chomp, cpu_time, rchar, wchar, rss)
			
			# second line onwards subtract from previous.
			else
				data = line.split(",").map! &:to_i
				cpu_time = data[@keys["cpu_time"]]
				rchar = data[@keys["rchar"]]
				wchar = data[@keys["wchar"]]
				rss = data[@keys["rss"]]
	
				cpu_time -= old_line[@keys["cpu_time"]]
				rchar -= old_line[@keys["rchar"]]
				wchar -= old_line[@keys["wchar"]]
				rss -= old_line[@keys["rss"]]
	
				new_file.puts to_csv(line.chomp, cpu_time, rchar, wchar, rss)
			end
	
			old_line = line.split(",").map! &:to_i
		
		end
	
		new_file.close
		new_file
	
	end

end