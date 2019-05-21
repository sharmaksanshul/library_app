class WelcomeController < ApplicationController

	def home
		if book_keeper_signed_in?
			redirect_to books_path
		elsif student_signed_in?
			redirect_to books_path	
		else
			render 'welcome/home'
		end 
	end
end
