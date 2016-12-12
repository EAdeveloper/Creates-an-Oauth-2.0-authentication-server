class Api::CoursesController < ApplicationController
	before_action :doorkeeper_authorize!

	def index
		@courses = Course.all 
	end
end