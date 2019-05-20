class BookKeepersController < ApplicationController
	before_action :authenticate_admin? , only: [:show_books,:show]
	def show_books
		@books = Book.all
	end

	def show
		@book_keeper = BookKeeper.find(params[:id])
	end

	private

	def authenticate_admin? 
		redirect_to root_path unless book_keeper_signed_in?
	end
end
