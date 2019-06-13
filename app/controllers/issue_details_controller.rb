class IssueDetailsController < ApplicationController
	before_action :authenticate_book_keeper, only: [:create, :update, :edit]
	before_action :find_issue_detail, only: [:edit, :update]
	
	def create 
		@book = Book.find(params[:book_id])
		@issue_detail = @book.issue_details.new(details_params)
		if @issue_detail.save
			redirect_to books_path
		else
			render 'books/issue'
		end
	end

	def edit
		# @issue_detail.fine = (Date.tomorrow - @issue_detail.exp_recieved_date)*10
	end

	def update	
		details = details_params
		fine = details[:fine].to_i
		if fine > 0
			redirect_to new_checkout_path(id: @issue_detail.id, fine: fine)
		else
			if @issue_detail.update_attributes(details_params)
	      flash[:success] = "Record updated"
	      redirect_to books_path
	    else
	      render 'edit'
	    end
		end
	end

	private

	def find_issue_detail
		@issue_detail = IssueDetail.find(params[:id])
	end

	def details_params
		params.require(:issue_detail).permit(:student_id, :issue_date, :exp_recieved_date,
		 :act_recieved_date, :fine)
	end

	def authenticate_book_keeper
		redirect_to root_path unless book_keeper_signed_in?
	end
end
