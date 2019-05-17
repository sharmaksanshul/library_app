class WelcomeController < ApplicationController

	def new

		if book_keeper_signed_in?
			@book_keeper = current_book_keeper
			redirect_to allbooks_path
		else
			render 'welcome/new'
		end 

	end

end
