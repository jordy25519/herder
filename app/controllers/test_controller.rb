class TestController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:index]
	
	def index
		@tests =  Dir.glob('./tests/*')
		@tests.map! { |e| e.split("/").last + "/" }
		if request.post?
			@test = params[:test]
			@size = Dir.glob(@test + "*").count
			redirect_to 'index'
		else
			@test = Dir.glob('./tests/*').first + "/"
			@size = Dir.glob(@test + "*").count
		end
	end

	def io
	end

	def cpu
		@path = "/home/jordanbeauchamp/projects/herder/tests/aviarcs 10 2015-07-23 10:55/"
	end

end
