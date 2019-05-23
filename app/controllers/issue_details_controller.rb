class IssueDetailsController < ApplicationController

	def create 
		@book= Book.find(params[:book_id])
		@issue_detail = @book.issue_details.new(details_params)
		if @issue_detail.save
			redirect_to books_path
		else
			redirect_to @book
		end
	end

	def update

	end

	private
	def details_params
		params.require(:issue_detail).permit(:student_id, :issue_date, :exp_recieved_date)
	end
end
