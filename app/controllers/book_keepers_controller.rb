class BookKeepersController < ApplicationController

	def showbooks
		@books = Book.all
	end

	def show
		@book_keeper = BookKeeper.find(params[:id])
	end
end
