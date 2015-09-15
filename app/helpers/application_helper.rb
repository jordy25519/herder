module ApplicationHelper
# Return list of filter options for CSV.
	def filter_options
	  [
	    "Memory (bytes)",
	    "Memory Cache (bytes)",
	    "CPU Time (nanoseconds)",
	    "IO Read (bytes)",
  	    "IO Write (bytes)",
  	    "IO Synchronous (bytes)",
  	    "IO Asynchronous (bytes)"
  	  ] 
	end
end
