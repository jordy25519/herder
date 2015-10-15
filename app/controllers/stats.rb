Dir.glob("tests/aviarc-minimals*").each do |d|
	puts IO.readlines(d + "/stat.txt").last
end