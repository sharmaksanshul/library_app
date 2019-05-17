class BookKeepersController < ApplicationController

	def show_books
		@books = Book.all
	end

	def show
		@book_keeper = BookKeeper.find(params[:id])
	end
end
