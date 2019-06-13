class StudentsController < ApplicationController
	before_action :authenticate_as_student, only: [:show, :issue_history]
	before_action :authenticate_as_book_keeper, only: [:current_active_issue]
	before_action :find_student, only: [:show, :issue_history, :current_active_issue]
	
	def show 
	
	end

	def current_active_issue
		if @student
			@details = @student.issue_history.where(act_recieved_date: nil)
		else
			flash[:alert] = "Student Does not Exist With This Roll no. "
			redirect_to find_student_path
		end
	end

	def issue_history
		@details = @student.issue_history
	end
	
	private

	def authenticate_as_student
		redirect_to root_path unless student_signed_in?
  end

  def authenticate_as_book_keeper
		redirect_to root_path unless book_keeper_signed_in?
  end

  def find_student
  	if book_keeper_signed_in?
  		@student = Student.find_by(id: params[:id])
  	else
  		@student = Student.find(params[:id])
  	end
  end
end
