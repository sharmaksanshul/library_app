class StudentsController < ApplicationController
	before_action :authenticate_as_student?, only: [:show, :issue_history]
	
	def show 
	
	end

	def issue_history
		@issue_history = @student.issue_history
	end
	private

	def authenticate_as_student?
		@student = Student.find(params[:id])
		redirect_to root_path unless student_signed_in? 
  end
end
