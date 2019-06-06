class StudentsController < ApplicationController
	before_action :authenticate_as_student?, only: [:show, :issue_history]
	before_action :authenticate_as_book_keeper?, only: [:current_active_issue]
	before_action :find_student, only: [:show, :issue_history, :current_active_issue]
	
	def show 
	
	end

	def current_active_issue
		@details = @student.issue_details.includes(:book).where(act_recieved_date:nil)
	end

	def issue_history
		@issue_history = @student.issue_history
	end
	
	private

	def authenticate_as_student?
		redirect_to root_path unless student_signed_in?
  end

  def authenticate_as_book_keeper?
		redirect_to root_path unless book_keeper_signed_in?
  end

  def find_student
  	@student = Student.find(params[:id])
  end
end
