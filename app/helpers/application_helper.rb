module ApplicationHelper
# Return list of filter options for CSV.
	def filter_options
		[
			"Memory (bytes)",
			"Memory instant (bytes)",
			"CPU usage (USER_HZ)",
			"CPU time (nanoseconds)",
			"CPU instant (nanoseconds)",
			"IO read (bytes)",
  		"IO write (bytes)",
  		"IO read instant (bytes)",
  		"IO write instant (bytes)",
  		"IO unpaged read (bytes)",
  		"IO unpaged write (bytes)"
  	]  
	end
end
