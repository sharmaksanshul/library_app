class StudentsController < ApplicationController
	before_action :authenticate_as_student?, only: [:show]
	
	def show 
		@student = Student.find(params[:id])
	end

	# def show_avail_books
	# 	@books = Book.all
	# end

	def authenticate_as_student?
		redirect_to root_path unless student_signed_in?
  end
end
