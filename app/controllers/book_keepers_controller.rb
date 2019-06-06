class BookKeepersController < ApplicationController
	before_action :authenticate_admin?, only: [:show]
	
	def show
		@book_keeper = BookKeeper.find(params[:id])
	end

	def find_student

	end

	private

	def authenticate_admin? 
		redirect_to root_path unless book_keeper_signed_in?
	end
end
