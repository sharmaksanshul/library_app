class BooksController < ApplicationController
	before_action  :authenticating_user , only: [:new ,:create,:destroy]

	def new
		@book = Book.new
	end

	def create

		@book = Book.new(user_params)
		if @book.save
			flash[:info] = "book added successfully"
			@book_keeper = current_book_keeper
			redirect_to @book_keeper
		else
			flash[:info] = "some error in saving the book"
			redirect_to root_path
		end	

	end

	def show

	end

	def index

	end

	def destroy

		@book = Book.find(params[:id])
		if @book.destroy 
			 @book_keeper = current_book_keeper
			redirect_to @book_keeper
		else
			flash[:info] = "some error in saving the book"
			redirect_to root_path
		end
		
	end

	private

	def user_params
		params.require(:book).permit(:name, :author, :no_of_copies,:picture)
	end

	def authenticating_user
		redirect_to root_path unless book_keeper_signed_in?
	end


end
