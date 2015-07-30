module ApplicationHelper
# Return list of filter options for CSV.
	def filter_options
		["Memory (bytes)",
		"CPU usage (USER_HZ)",
		"CPU time (nanoseconds)",
		"IO paged (bytes)",
		"IO unpaged (bytes)"] 
	end
end
