module ApplicationHelper

    # Return list of filter options for test data.
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

    # Return list of filter options for io rate.
	def io_rate_options
	  [
	    "Read IO (requests)",
        "Read Merges (requests)",
		"Read Sectors (sectors)",
		"Read Ticks (milliseconds)",
		"Write IO (requests)",
		"Write Merges (requests)",
		"Write Sectors (sectors)",
		"Write Ticks (milliseconds)",
		"In Flight (requests)",
		"IO Ticks (milliseconds)",
		"Time in Queue (milliseconds)",
		"Load Average"
	  ]
    end

end