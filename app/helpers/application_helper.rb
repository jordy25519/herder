module ApplicationHelper
# Return list of filter options for CSV.
	def filter_options
		[
			"Memory (bytes)",
			"Memory instant (bytes)",
			"CPU usage (USER_HZ)",
			"CPU time (nanoseconds)",
			"CPU instant (nanoseconds)",
			"IO paged (bytes)",
			"IO paged instant (bytes)",
			"IO unpaged (bytes)"] 
	end
end
