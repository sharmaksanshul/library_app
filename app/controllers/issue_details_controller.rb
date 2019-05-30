class IssueDetailsController < ApplicationController
	before_action :authenticate_book_keeper, only: [:create, :update, :edit]
	
	def create 
		@book= Book.find(params[:book_id])
		@issue_detail = @book.issue_details.new(details_params)
		if @issue_detail.save
			redirect_to books_path
		else
			redirect_to issue_book_path
		end
	end

	def edit
		@issue_detail = IssueDetail.find(params[:id])
		# @issue_detail.fine = (Date.tomorrow - @issue_detail.exp_recieved_date)*10
		# debugger
	end

	def update
		@issue_detail = IssueDetail.find(params[:id])
		@fine = params.require(:issue_detail).permit(:fine)
		if @fine[:fine].to_i > 0
			redirect_to new_checkout_path(issue_detail_id: @issue_detail.id)
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
	def details_params
		params.require(:issue_detail).permit(:student_id, :issue_date, :exp_recieved_date,
		 :act_recieved_date, :fine)
	end

	def authenticate_book_keeper
		redirect_to root_path unless book_keeper_signed_in?
	end
end
