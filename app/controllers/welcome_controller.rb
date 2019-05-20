class WelcomeController < ApplicationController

	def new

		if book_keeper_signed_in?
			# @book_keeper = current_book_keeper
			redirect_to books_path
		elsif student_signed_in?
			redirect_to books_path	
		else
			render 'welcome/new'
		end 

	end

end
